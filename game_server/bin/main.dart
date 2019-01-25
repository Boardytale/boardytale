import 'package:io_utils/io_utils.dart';
import 'package:shared/configuration/configuration.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

main() async {
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();
  final port = boardytaleConfiguration.gameServer.uris.first.port.toInt();

  var handler = webSocketHandler((webSocket) {
    webSocket.listen((message) {
      webSocket.add("echo $message");
    });
  });

  shelf_io.serve(handler, 'localhost', port).then((server) {
    print('Serving at ws://${server.address.host}:${server.port}');
  });
}

