import 'dart:io' as io;
import 'dart:convert';
import 'package:ai_server/ai_server.dart';
import 'package:shared/configuration/configuration.dart';
import 'package:io_utils/io_utils.dart';
import 'package:shared/model/model.dart' as shared;

main() async {
  final BoardytaleConfiguration config = getConfiguration();
  final port = config.gameServer.uris.first.port.toInt();
  int connectionId = 0;
  ServerGateway gateway = initServer(config);
  io.ServerSocket.bind("localhost", port).then((io.ServerSocket server) {
    server.listen((io.Socket socket) {
      Connection connection = Connection();
      connection.socket = socket;
      connection.id = connectionId++;
      socket.listen((data) {
        try {
          gateway.incomingMessage(MessageWithConnection()
            ..message = shared.ToAiServerMessage.fromJson(jsonDecode(String.fromCharCodes(data).trim()))
            ..connection = connection);
        } catch (e) {
          socket.write("message is not instance of ToGameServerMessage ${data}");
          print(e);
          return;
        }
      });
    });
  });
}
