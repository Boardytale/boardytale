import 'dart:io';
import 'package:io_utils/io_utils.dart';
import 'common.dart';

main() async {
  String projectDirectoryPath = harmonizePath();

  Function printRun = (ProcessResult process) {
    print(process.stdout.toString());
    print(process.stderr.toString());
  };

  printRun(
      Process.runSync(pubExecutable, ["get"], workingDirectory: projectDirectoryPath + "/editor_client"));

  printRun(Process.runSync(pubExecutable, ["get"],
      workingDirectory: projectDirectoryPath + "/editor_server"));

  printRun(Process.runSync(pubExecutable, ["get"], workingDirectory: projectDirectoryPath + "/libs/io_utils"));

  printRun(Process.runSync(pubExecutable, ["get"], workingDirectory: projectDirectoryPath + "/shared"));

  printRun(Process.runSync(pubExecutable, ["get"], workingDirectory: projectDirectoryPath + "/typescript_generator"));
  printRun(Process.runSync(pubExecutable, ["get"], workingDirectory: projectDirectoryPath + "/user_server"));
}
