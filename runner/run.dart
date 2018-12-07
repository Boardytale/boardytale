import 'dart:convert';
import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'common.dart';
import 'package:shared/configuration/configuration.dart';

main() async {
  String projectDirectoryPath = harmonizePath();

  print('project directory path $projectDirectoryPath');
  BoardytaleConfiguration config;

  try {
    config =
        BoardytaleConfiguration.fromJson(json.decode(File(projectDirectoryPath + '/config.json').readAsStringSync()));
  }catch(e){
    if(e is CheckedFromJsonException){
      throw e;
    }
    throw e;
  }

  print(config.proxyServer.uris.first.port);

//  childProcess.execFile('ts-node', [
//    'proxy_server/index.ts'
//  ], function(err, stdout, stderr) {
//      // Node.js will invoke this callback when the
//      console.log(stdout);
//});
//
//  childProcess.execFile('proxy_server/index.ts', [
//  ], function(err, stdout, stderr) {
//  // Node.js will invoke this callback when the
//  console.log(stdout);
//  });
//
//
//  print("OPEN BROWSER ON http://localhost:8080");
//  Process.start(dartExecutable,
//      ["lib/server.dart"],
//      workingDirectory: projectDirectoryPath + "/server")
//      .then((Process process) {
//    printFromOutputStreams(process, "Shelf proxy", "light_cyan");
//  });
//
//  Process.start(pubExecutable,
//      ["serve", "--port=8085"],
//    workingDirectory: projectDirectoryPath + "/client"
//  ).then((Process process) {
//    printFromOutputStreams(process, "Pub serve", "gold");
//  });
//
//  Process.start(dartExecutable,
//      ["web_server.dart"],
//      workingDirectory: projectDirectoryPath + "/runner")
//      .then((Process process) {
//        process.stdout.listen((_){
//          // have to be listened or process will end
//        });
////    printFromOutputStreams(process, "web_server", "green");
//  });
}
