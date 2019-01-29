library boardytale.client.gateway;

import 'dart:convert';
import 'dart:html';

import 'package:angular/di.dart';
import 'package:shared/model/model.dart' as shared;
import '../../project_settings.dart';

@Injectable()
class GatewayService {
  WebSocket _socket;
//  String connectionName;
//  Player me;

  Map<shared.OnClientAction, void Function(shared.ToClientMessage message)>
      handlers = {};

//  Stream get onChange => _onChange.stream;
//  StreamController _onChange = StreamController();

//  Stream<Map<String, dynamic>> get onMessage => _onMessage.stream;
//  StreamController<Map<String, dynamic>> _onMessage =
//      StreamController<Map<String, dynamic>>();

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
      Map<String, dynamic> message = json.decode(e.data.toString());
      handleMessages(shared.ToClientMessage.fromJson(message));
    });
    _socket.onOpen.listen((_) {
      sendMessage(shared.ToGameServerMessage.init());
    });
  }

  void sendMessage(shared.ToGameServerMessage message) {
    _socket.send(json.encode(message.toJson()));
  }

  void handleMessages(shared.ToClientMessage message) {
    if (handlers.containsKey(message.message)) {
      handlers[message.message](message);
    } else {
      throw "missing handler for ${jsonEncode(message.toJson())}";
    }

//    print("Message ${message["type"]}");
////    print(JSON.encode(message));
//    if (!message.containsKey("type")) {
//      throw ("Message do not contain \"type\"");
//    }
//    switch (message["type"]) {
//      case "error":
//        state.alertError(message["message"]);
//        break;
//      case "message":
//        state.alertNote(message["message"]);
//        break;
//      case "connection":
//        connectionName = message["name"];
//        updateMe();
//        break;
//      case "cancel":
//        state.alertWarning(message["reason"]);
//        break;
//      case "tale":
//        state.loadTaleFromData(message["tale"]);
//        updateMe();
//        break;
//      case "state":
//        state.teamPlaying = message["playing"];
//        state.tale.update(message);
//        updateMe();
//        break;
//      case "ping":
//        state.alertNote(message["message"]);
//        break;
//      default:
//        throw new UnimplementedError("Type ${message["type"]} unimplemented");
//    }
//    _onMessage.add(message);
  }

//  void updateMe() {
////    if (connectionName == null || state.tale == null) {
////      me = null;
////      return;
////    }
////    me = state.tale.players.values.firstWhere(
////        (player) => (player as Player).connectionName == connectionName,
////        orElse: returnNull);
////    if (me != null) {
////      state.tale.players.values.forEach((player) {
////        (player as Player).isEnemy = player.team != me.team;
////        (player as Player).isMe = false;
////      });
////      me.isMe = true;
////    }
//  }

//
//  void sendCommand(Unit unit, List<String> path, shared.Ability ability,
//      {Map<String, dynamic> other: const {}}) {
//    _send({
//      "type": "command",
//      "unit": unit.id,
//      "ability": ability.name,
//      "path": path
//    }..addAll(other));
//  }
//
//  void sendNextTurn() {
//    _send({"type": "nextTurn"});
//  }
}
