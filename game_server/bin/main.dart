import 'dart:convert';
import 'package:game_server/game_server.dart';
import 'package:io_utils/io_utils.dart';
import 'package:shared/configuration/configuration.dart';
import 'package:shared/model/model.dart' as shared;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

main() async {
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();
  final port = boardytaleConfiguration.gameServer.uris.first.port.toInt();

  ServerGateway gateway = ServerGateway();

  var handler = webSocketHandler((WebSocketChannel webSocket) {
    gateway.webSocket = webSocket;
    webSocket.stream.listen((data) {
      try {
        gateway.incomingMessage(shared.ToGameServerMessage.fromJson(jsonDecode(data)));
      } catch (e) {
        webSocket.sink
            .add("message is not instance of ToGameServerMessage ${data}");
        print(e);
        return;
      }

    });
  });

  shelf_io.serve(handler, 'localhost', port).then((server) {
    print('Serving game server at ws://${server.address.host}:${server.port}');
  });
}
