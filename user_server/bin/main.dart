import 'package:user_server/user_server.dart';
import 'package:io_utils/io_utils.dart';
import 'package:core/configuration/configuration.dart';

Future main() async {
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();

  print("current directory ${Directory.current.path}");

  final app = Application<UserServerChannel>()
    ..options.port = boardytaleConfiguration.userServer.uris.first.port.toInt();

  await app.start(numberOfInstances: 1);
//  final count = Platform.numberOfProcessors ~/ 2;
//  await app.start(numberOfInstances: count > 0 ? count : 1);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
