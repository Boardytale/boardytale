import 'dart:convert';
import 'package:ai_server/ai_server.dart';
import 'package:core/configuration/configuration.dart';
import 'package:io_utils/io_utils.dart';
import 'package:core/model/model.dart' as core;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

main() async {
  final BoardytaleConfiguration config = getConfiguration();
  final port = config.aiServer.uris.first.port.toInt();
  int connectionId = 0;
  ServerGateway gateway = initServer(config);

  var handler = webSocketHandler((WebSocketChannel webSocket) {
    Connection connection = Connection();
    connection.socket = webSocket;
    connection.id = connectionId++;

    webSocket.stream.listen((data) {
      try {
        gateway.incomingMessage(MessageWithConnection()
          ..message = core.ToAiServerMessage.fromJson(jsonDecode(data))
          ..connection = connection);
      } catch (e) {
        webSocket.sink.add("message is not instance of ToAiServerMessage ${data}");
        print(e);
        return;
      }
    });
  });

  shelf_io.serve(handler, 'localhost', port).then((server) {
    print('Serving ai server at ws://${server.address.host}:${server.port}');
  });
}
