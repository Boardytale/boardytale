import 'dart:convert';
import 'dart:io';
import 'package:io_utils/io_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'common.dart';
import 'package:shared/configuration/configuration.dart';

main() async {
  Directory.current = getProjectDirectory();
  String projectDirectoryPath = harmonizePath();

  print('project directory path $projectDirectoryPath');
  BoardytaleConfiguration config;

  try {
    config = BoardytaleConfiguration.fromJson(json.decode(
        File(projectDirectoryPath + '/config.json').readAsStringSync()));
  } catch (e) {
    if (e is CheckedFromJsonException) {
      print(e.innerError.toString());
    }
    throw e;
  }

  print(config.proxyServer.uris.first.port);

  print(
      "OPEN BROWSER ON http://localhost:${config.proxyServer.uris.first.port}");

  runServerByServerConfiguration(config.proxyServer);

  runServerByServerConfiguration(config.userServer);

  runServerByServerConfiguration(config.editorServer);

  runServerByServerConfiguration(config.heroesServer);

//  Process.start(dartExecutable, ["lib/server.dart"], workingDirectory: projectDirectoryPath + "/server")
//      .then((Process process) {
//    printFromOutputStreams(process, "Shelf proxy", "light_cyan");
//  });

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

void runServerByServerConfiguration(ServerConfiguration config) {
  String projectDirectoryPath = harmonizePath();
  String executable;
  if (config.executableType == ExecutableType.dart) {
    executable = dartExecutable;
  }
  if (config.executableType == ExecutableType.js) {
    executable = 'node';
  }
  if (config.executableType == ExecutableType.tsNode) {
    executable = 'ts-node';
  }

  String executableFile =
      slashesInPath(projectDirectoryPath + "/" + config.pathToExecutable);
  String workingDirectory =
      slashesInPath(projectDirectoryPath + "/" + config.pathToWorkingDirectory);

  Process.start(executable, [executableFile],
      workingDirectory: workingDirectory, runInShell: true)
    ..then((Process process) {
      print(
          "running ${config.pathToExecutable} on port ${config.uris.first.port} pid: ${process.pid}");
      printFromOutputStreams(process, config.pathToExecutable, "light_cyan");
    });
  ;
}
