import 'dart:io';
import 'package:io_utils/io_utils.dart';
import 'common.dart';
import 'dart:async';

main() async {
  String projectDirectoryPath = harmonizePath();

  Function printRun = (ProcessResult process) {
    print(process.stdout.toString());
    print(process.stderr.toString());
  };

  printRun(
      Process.runSync(pubExecutable, ["get"], workingDirectory: projectDirectoryPath + "/client"));

  printRun(Process.runSync(pubExecutable, ["get"],
      workingDirectory: projectDirectoryPath + "/boardytale_commons"));

  printRun(Process.runSync(pubExecutable, ["get"], workingDirectory: projectDirectoryPath + "/io_utils"));

  printRun(Process.runSync(pubExecutable, ["get"], workingDirectory: projectDirectoryPath + "/server"));

  printRun(Process.runSync(pubExecutable, ["get"], workingDirectory: projectDirectoryPath + "/utils"));
}
