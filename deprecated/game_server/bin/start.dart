import 'dart:async';
import 'dart:io';

import 'package:aqueduct/aqueduct.dart';
import 'package:game_server/channel.dart';

main() async {
  try {
    var app = new Application<BoardyTaleChannel>()
      ..options.configurationFilePath = "config.yaml"
      ..options.port = 8888;

    final count = Platform.numberOfProcessors ~/ 2;
    await app.start(numberOfInstances: count > 0 ? count : 1);

    print("Application started on port: ${app.options.port}.");
    print("Use Ctrl-C (SIGINT) to stop running the application.");
  } catch (e, st) {
    await writeError("$e\n $st");
  }
}

Future writeError(String error) async {
  print("$error");
}
