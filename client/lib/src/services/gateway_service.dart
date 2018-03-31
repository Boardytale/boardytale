library boardytale.client.gateway;

import 'dart:convert';
import 'dart:html';

import 'package:angular/di.dart';
import 'package:boardytale_client/src/services/state_service.dart';
import 'package:boardytale_client/src/world/model/model.dart';
import 'package:boardytale_commons/model/model.dart' as commonLib;
import 'package:utils/utils.dart';

@Injectable()
class GatewayService {
  WebSocket _socket;
  String connectionName;
  Player me;
  final StateService state;
  Notificator onChange = new Notificator();
  ValueNotificator<Map<String, dynamic>> onMessage = new ValueNotificator<Map<String, dynamic>>();

  GatewayService(this.state) {
    _socket = new WebSocket('ws://127.0.0.1:8086/ws');
    _socket.onMessage.listen((MessageEvent e) {
      Map<String, dynamic> message = JSON.decode(e.data.toString());
      handleMessages(message);
    });
//    socket.onOpen.listen((_) {
    //      socket.send(JSON.encode({"type": "ping", "message": "ahoj"}));
//    });
  }

  void handleMessages(Map<String, dynamic> message) {
    print("Message ${message["type"]}");
    if (!message.containsKey("type")) {
      throw ("Message do not contain \"type\"");
    }
    switch (message["type"]) {
      case "error":
        state.alertError(message["message"]);
        break;
      case "message":
        state.alertNote(message["message"]);
        break;
      case "connection":
        connectionName = message["name"];
        updateMe();
        break;
      case "cancel":
        state.alertWarning(message["reason"]);
        break;
      case "tale":
        state.loadTaleFromData(message["tale"]);
        updateMe();
        break;
      case "state":
        state.tale.update(message);
        updateMe();
        break;
      case "ping":
        state.alertNote(message["message"]);
        break;
      default:
        throw new UnimplementedError("Type ${message["type"]} unimplemented");
    }
    onMessage.notify(message);
  }

  void updateMe() {
    if (connectionName == null || state.tale == null) {
      me = null;
      return;
    }
    me = state.tale.players.values
        .firstWhere((player) => (player as Player).connectionName == connectionName, orElse: () => null);
    if (me != null) {
      state.tale.players.values.forEach((player) {
        (player as Player).isEnemy = player.team != me.team;
        (player as Player).isMe = false;
      });
      me.isMe = true;
    }
  }

  void _send(Map<String, dynamic> message) {
    _socket.send(JSON.encode(message));
  }

  void sendCommand(Unit unit, List<String> path, commonLib.Ability ability, {Map<String, dynamic> other: const {}}) {
    _send({"type": "command", "unit": unit.id, "ability": ability.name, "path": path}..addAll(other));
  }
}
