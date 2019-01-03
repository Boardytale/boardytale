import 'package:editor_server/editor_server.dart';
import 'package:io_utils/io_utils.dart';
import 'package:shared/configuration/configuration.dart';

Future main() async {
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();
  final app = Application<UserServerChannel>()
    ..options.port = boardytaleConfiguration.editorServer.uris.first.port.toInt();
  await app.start(numberOfInstances: 1);
  print("Application started on port: ${app.options.port}.");
}
