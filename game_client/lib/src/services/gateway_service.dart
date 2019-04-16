library boardytale.client.gateway;

import 'dart:convert';
import 'dart:html';

import 'package:angular/di.dart';
import 'package:core/model/model.dart' as core;
import 'package:game_client/project_settings.dart';

@Injectable()
class GatewayService {
  WebSocket _socket;
  bool _opened = false;
  List<core.ToGameServerMessage> _beforeOpenBuffer = [];
  Map<core.OnClientAction, void Function(core.ToClientMessage message)> handlers = {};

  GatewayService() {
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
      _beforeOpenBuffer.forEach((message) => sendMessage(message));
      _beforeOpenBuffer.clear();
    });
  }

  void initMessages(String innerToken) {
    sendMessage(core.ToGameServerMessage.init(innerToken));
  }

  void sendMessage(core.ToGameServerMessage message) {
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
    sendMessage(core.ToGameServerMessage.playerGameIntention(fields?.map((f) {
      return f.id;
    })?.toList()));
  }
}
