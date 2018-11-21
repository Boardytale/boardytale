import 'package:user_server/user_server.dart';
import 'package:io_utils/io_utils.dart';

Future main() async {
  Map config = getConfig();

  final app = Application<UserServerChannel>()
      ..options.configurationFilePath = "config.yaml"
      ..options.port = 8888;

  final count = Platform.numberOfProcessors ~/ 2;
  await app.start(numberOfInstances: count > 0 ? count : 1);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}