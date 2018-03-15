import 'dart:io';
import 'package:io_utils/io_utils.dart';
import 'common.dart';

void main() {
  String projectDirectoryPath = harmonizePath();
  print("OPEN BROWSER ON http://localhost:8080");
//  Process.start(dartExecutable,
//      ["lib/server.dart"],
//      workingDirectory: projectDirectoryPath + "/server")
//      .then((Process process) {
//    printFromOutputStreams(process, "Shelf proxy", "light_cyan");
//  });

  Process.start(pubExecutable,
      ["serve", "--port=8085"],
      workingDirectory: projectDirectoryPath + "/client"
  ).then((Process process) {
    printFromOutputStreams(process, "Pub serve", "gold");
  });

  Process.start(dartExecutable,
      ["web_server.dart"],
      workingDirectory: projectDirectoryPath + "/runner")
      .then((Process process) {
    printFromOutputStreams(process, "web_server", "green");
  });

}