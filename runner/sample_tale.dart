import 'dart:io';
import 'dart:convert';
import 'package:io_utils/io_utils.dart';
import 'common.dart';

main() {
  String projectDirectoryPath = harmonizePath();

  Process.start("npm.cmd",
      ["run", "compile"],
      workingDirectory: projectDirectoryPath + "/sample_tale_json")
      .then((Process process) {
        process.stdout.listen((data){
          print(new String.fromCharCodes(data));
          print(JSON.encode(JSON.decode(new String.fromCharCodes(data))));
        });
//    printFromOutputStreams(process, "sample");
  });
}