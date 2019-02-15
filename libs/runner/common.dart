import 'dart:io';

String harmonizePath() {
  if (Platform.isWindows) {
    if (slashesInPath(Directory.current.path).split("/").last == "runner") {
      return new Directory("../").path;
    }
  } else {
    if (slashesInPath(Directory.current.path).split("/").last == "runner") {
      return new Directory("../").path;
    }
  }
  return Directory.current.path;
}

String slashesInPath(String path) {
  return path.replaceAll('\\', '/');
}
