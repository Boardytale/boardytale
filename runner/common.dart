import 'dart:io';

String harmonizePath() {
  if(Platform.isWindows){
    if (Directory.current.path
        .split("\\")
        .last == "runner") {
      return new Directory("../").path;
    }
  }else{
    if (Directory.current.path.split(new RegExp("[\\/]")).last == "runner") {
      return new Directory("../").path;
    }
  }
  return Directory.current.path;
}
