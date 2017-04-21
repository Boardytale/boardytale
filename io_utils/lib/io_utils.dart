import 'dart:io';
import 'package:path/path.dart' as path_lib;
import 'package:utils/utils.dart';

Map<String, dynamic> getFileMap(Directory dir) {
  Map<String, dynamic> out = {};
  for (FileSystemEntity f in dir.listSync()) {
    if (FileSystemEntity.isFileSync(f.path)) {
      File file = new File(f.path);
      String ext = path_lib.extension(file.path);
      try {
        if (ext == ".jpg" || ext == ".png" || ext == ".jpeg" || ext == ".gif") {
          out[convertToCamelCase(path_lib.basename(f.path))] =
              file.readAsBytesSync();
        } else {
          out[convertToCamelCase(path_lib.basename(f.path))] =
              file.readAsStringSync();
        }
      } catch (e) {
        out[convertToCamelCase(path_lib.basename(f.path))] = "error";
      }
    } else if (FileSystemEntity.isDirectorySync(f.path)) {
      out[convertToCamelCase(path_lib.basenameWithoutExtension(f.path))] =
          getFileMap(new Directory(f.path));
    }
  }
  return out;
}