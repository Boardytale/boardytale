import 'package:core/configuration/configuration.dart';
import 'package:io_utils/io_utils.dart';
import 'dart:io';

Future main() async {
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();
  String projectDirectoryPath = getProjectDirectory().path;

  Process.start("webdev",
          ["serve", "web:${boardytaleConfiguration.editorStaticDev.port}"],
          runInShell: true,
          workingDirectory: "${projectDirectoryPath}/editor_client")
      .then((Process process) {
    printFromOutputStreams(process, "editor serve", "light_cyan");
  });
}
