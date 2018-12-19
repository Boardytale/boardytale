import 'package:shared/configuration/configuration.dart';
import 'package:io_utils/io_utils.dart';
import 'dart:io';

Future main() async {
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();

  Process.start("webdev", ["serve", "web:${boardytaleConfiguration.editorStaticDev.port}"], runInShell: true)
      .then((Process process) {
    printFromOutputStreams(process, "editor serve", "light_cyan");
  });

}