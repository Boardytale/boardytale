import 'dart:convert';
import 'dart:io' as io;
import 'package:core/model/model.dart' as core;

main() {
  io.WebSocket.connect("ws://boardytale.vserver.cz:80/").then((io.WebSocket socket) {
    socket.add(json.encode(core.ToGameServerMessage.createInit("aaa").toJson()));
    socket.listen((dynamic aiServerData) {
      String messageString = aiServerData.toString();
      print(messageString);
    });
  });
}
