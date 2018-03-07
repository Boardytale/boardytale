import 'dart:io';

String harmonizePath() {
  if (Directory.current.path.split(new RegExp("[\\/]")).last == "runner") {
    return new Directory("../").path;
  }

  return Directory.current.path;
}
