import 'dart:io';
import 'package:io_utils/io_utils.dart';
import 'common.dart';

void main() {
  String projectDirectoryPath = harmonizePath();

  Process.start(dartExecutable,
      ["bin/start.dart"],
      workingDirectory: projectDirectoryPath + "/server")
      .then((Process process) {
    printFromOutputStreams(process, "Aqueduct");
  });

  Process.start(pubExecutable,
      ["serve", "--port=8085"],
    workingDirectory: projectDirectoryPath + "/client"
  ).then((Process process) {
    printFromOutputStreams(process, "Pub serve");
  });

  Process.start(dartExecutable,
      ["web_server.dart"],
      workingDirectory: projectDirectoryPath + "/runner")
      .then((Process process) {
    printFromOutputStreams(process, "web_server");
  });

}