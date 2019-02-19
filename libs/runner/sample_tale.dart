import 'dart:io';
import 'dart:convert';
import 'common.dart';

main() {
  String projectDirectoryPath = harmonizePath();

  if (!Platform.isWindows) {
    throw "Sorry Cesťo, není to udělaný pro linux";
  }

  Process.start("npm.cmd", ["run", "compile"],
          workingDirectory: projectDirectoryPath + "/sample_tale_json")
      .then((Process process) {
    process.stdout.listen((data) {
      print(new String.fromCharCodes(data));
      print(json.encode(json.decode(new String.fromCharCodes(data))));
    });
//    printFromOutputStreams(process, "sample");
  });
}
