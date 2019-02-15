library boardytale.client.gateway;

import 'dart:convert';
import 'dart:html';

import 'package:angular/di.dart';
import 'package:shared/model/model.dart' as shared;
import '../../project_settings.dart';

@Injectable()
class GatewayService {
  WebSocket _socket;
  bool _opened = false;
  List<shared.ToGameServerMessage> _beforeOpenBuffer = [];
  Map<shared.OnClientAction, void Function(shared.ToClientMessage message)>
      handlers = {};

  GatewayService() {
    var loc = window.location;
    String newUri;
    if (loc.protocol == "https:") {
      newUri = "wss:";
    } else {
      newUri = "ws:";
    }
    newUri += "//" + loc.host;
    _socket = WebSocket(
        '${newUri}:${ProjectSettings.gameApiPort}${ProjectSettings.gameApiRoute}/ws');
    _socket.onMessage.listen((MessageEvent e) {
      print("got message");
      Map<String, dynamic> message = json.decode(e.data.toString());
      handleMessages(shared.ToClientMessage.fromJson(message));
    });
    _socket.onOpen.listen((_) {
      _opened = true;
      _beforeOpenBuffer.forEach((message) => sendMessage(message));
      _beforeOpenBuffer.clear();
    });
  }

  void initMessages(String innerToken) {
    sendMessage(shared.ToGameServerMessage.init(innerToken));
  }

  void sendMessage(shared.ToGameServerMessage message) {
    if (!_opened) {
      _beforeOpenBuffer.add(message);
    } else {
      _socket.send(json.encode(message.toJson()));
    }
  }

  void handleMessages(shared.ToClientMessage message) {
    if (handlers.containsKey(message.message)) {
      print("handle message ${message.message}");
      handlers[message.message](message);
    } else {
      throw "missing handler for ${jsonEncode(message.toJson())}";
    }
  }
}
