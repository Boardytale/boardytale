import 'dart:async';
import 'dart:io';

import 'package:aqueduct/aqueduct.dart';
import 'package:boardytale_server/boardytale_server.dart';

main() async {
  try {
    var app = new Application<BoardytaleRequestSink>();
    var config = new ApplicationConfiguration()
      ..port = 8086
      ..configurationFilePath = "config.yaml";

    app.configuration = config;

    await app.start(numberOfInstances: 3);
  } catch (e, st) {
    await writeError("$e\n $st");
  }
}

Future writeError(String error) async {
  print("$error");
}