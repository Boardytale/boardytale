library boardytale.client.gateway;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/di.dart';
import 'package:core/model/model.dart' as core;
import 'package:game_client/project_settings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

@Injectable()
class GatewayService {
  WebSocket _socket;
  bool _opened = false;
  bool reconnecting = false;
  BehaviorSubject<int> reconnectingTime = BehaviorSubject(seedValue: 0);
  List<core.ToGameServerMessage> _beforeOpenBuffer = [];
  Map<core.OnClientAction, void Function(core.ToClientMessage message)> handlers = {};
  final http.Client _http;

  GatewayService(this._http) {
    var loc = window.location;
    String newUri;
    if (loc.protocol == "https:") {
      newUri = "wss:";
    } else {
      newUri = "ws:";
    }
    newUri += "//" + loc.hostname;
    _socket = WebSocket('${newUri}:${ProjectSettings.gameApiPort}${ProjectSettings.gameApiRoute}/ws');
    _socket.onMessage.listen((MessageEvent e) {
      Map<String, dynamic> message = json.decode(e.data.toString());
      handleMessages(core.ToClientMessage.fromJson(message));
    });
    _socket.onOpen.listen((_) {
      _opened = true;
      _beforeOpenBuffer.forEach((message) => toGameServerMessage(message));
      _beforeOpenBuffer.clear();
    });
    _socket.onClose.listen(reconnect);
    _socket.onError.listen(reconnect);
  }

  void reconnect([_]) async {
    var reloads = 0;
    var key = "reloads";
    var lastKey = "lastReloadsWrite";
    if (window.localStorage.containsKey(key)) {
      reloads = int.tryParse(window.localStorage[key]) ?? 5;
      if (window.localStorage.containsKey(lastKey)) {
        try {
          if (DateTime.now().millisecondsSinceEpoch -
                  DateTime.parse(window.localStorage[lastKey]).millisecondsSinceEpoch >
              500000) {
            reloads = 0;
          }
        } catch (e) {
          reloads = 5;
        }
      }
    }
    reconnecting = true;
    reconnectingTime.add(reloads * reloads);
    await Future.delayed(Duration(seconds: (reloads * reloads)));
    window.localStorage[key] = "${++reloads}";
    window.localStorage[lastKey] = "${DateTime.now().toUtc()}";
    // if frequency is lower then once per 100 games, full reload is sufficient solution
    window.location.reload();
  }

  void initMessages(String innerToken) {
    toGameServerMessage(core.ToGameServerMessage.createInit(innerToken));
  }

  void toGameServerMessage(core.ToGameServerMessage message) {
    if (!_opened) {
      _beforeOpenBuffer.add(message);
    } else {
      _socket.send(json.encode(message.toJson()));
    }
  }

  void handleMessages(core.ToClientMessage message) {
    if (handlers.containsKey(message.message)) {
      handlers[message.message](message);
    } else {
      throw "missing handler for ${jsonEncode(message.toJson())}";
    }
  }

  void sendIntention(List<core.Field> fields) {
    toGameServerMessage(core.ToGameServerMessage.createPlayerIntention(fields?.map((f) {
      return f.id;
    })?.toList()));
  }

  Future<core.ToUserServerMessage> toUserServerMessage(core.ToUserServerMessage message) async {
    http.Response response = await _http.post("/userApi/toUserMessage",
        headers: {"Content-Type": "application/json"}, body: json.encode(message));
    Map<String, dynamic> responseBody;
    try{
      responseBody = json.decode(response.body);
    }catch(e){
      print(response.body);
      return core.ToUserServerMessage()..error = response.body;
    }
    if (response.statusCode == 200) {
      return core.ToUserServerMessage.fromJson(responseBody);
    } else {
      return core.ToUserServerMessage()..error = responseBody["message"];
    }
  }
}
