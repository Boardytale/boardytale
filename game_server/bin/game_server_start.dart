import 'dart:convert';
import 'dart:io';
import 'package:game_server/game_server.dart';
import 'package:io_utils/io_utils.dart';
import 'package:core/configuration/configuration.dart';
import 'package:core/model/model.dart' as core;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

main() async {
  final BoardytaleConfiguration config = getConfiguration();
  final port = config.gameServer.uris.first.port.toInt();
  int connectionId = 0;
  ServerGateway gateway = initServer(config);

  var handler = webSocketHandler((WebSocketChannel webSocket) {
    Connection connection = Connection();
    connection.webSocket = webSocket;
    connection.id = connectionId++;

    webSocket.stream.listen((data) {
      try {
        gateway.incomingMessage(MessageWithConnection()
          ..message = core.ToGameServerMessage.fromJson(jsonDecode(data))
          ..connection = connection);
      } catch (e) {
        webSocket.sink.add("message is not instance of ToGameServerMessage ${data}");
        print(e);
        return;
      }
    });
  });

  shelf_io.serve(handler, InternetAddress.anyIPv4, port).then((server) {
    print('Serving game server at ws://${server.address.host}:${server.port}');
  });
}
