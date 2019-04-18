import 'dart:convert';
import 'dart:io';
import 'package:io_utils/io_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:core/configuration/configuration.dart';

main() async {
  Directory.current = getProjectDirectory();
  String projectDirectoryPath = harmonizePath();

  print('project directory path $projectDirectoryPath');
  BoardytaleConfiguration config;

  try {
    config =
        BoardytaleConfiguration.fromJson(json.decode(File(projectDirectoryPath + '/config.g.json').readAsStringSync()));
  } catch (e) {
    if (e is CheckedFromJsonException) {
      print(e.innerError.toString());
    }
    throw e;
  }

  print(config.proxyServer.uris.first.port);

  print("OPEN BROWSER ON http://localhost:${config.proxyServer.uris.first.port}");

  runServerByServerConfiguration(config.proxyServer);

  runServerByServerConfiguration(config.userServer);

  runServerByServerConfiguration(config.editorServer);

  runServerByServerConfiguration(config.heroesServer);

  runServerByServerConfiguration(config.aiServer);

  runServerByServerConfiguration(config.gameServer);
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

  String executableFile = slashesInPath(projectDirectoryPath + "/" + config.pathToExecutable);
  String workingDirectory = slashesInPath(projectDirectoryPath + "/" + config.pathToWorkingDirectory);
  Process.start(executable, [executableFile], workingDirectory: workingDirectory, runInShell: true)
    ..then((Process process) {
      print("running ${config.pathToExecutable} on port ${config.uris.first.port} pid: ${process.pid}");
      printFromOutputStreams(process, config.pathToExecutable, "light_cyan");
    })
    ..catchError((onError) {
      print(onError);
    });
  ;
}
