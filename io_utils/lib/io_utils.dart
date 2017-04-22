import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path_lib;
import 'package:utils/utils.dart';

Map<String, dynamic> getFileMap(Directory dir) {
  Map<String, dynamic> out = {};
  for (FileSystemEntity f in dir.listSync()) {
    String key = convertToCamelCase(path_lib.basename(f.path));
    if (FileSystemEntity.isFileSync(f.path)) {
      File file = new File(f.path);
      String ext = path_lib.extension(file.path);
      try {
        if (ext == ".jpg" || ext == ".png" || ext == ".jpeg" || ext == ".gif") {
          String contentType = "image/${ext.replaceAll(".", "")}";
          List byteList = file.readAsBytesSync();
          String header = "data:$contentType;base64,";
          String base64 = BASE64.encode(byteList);
          out[key] = "$header$base64";
        } else {
          out[key] = file.readAsStringSync();
        }
      } catch (e) {
        out[key] = "error";
      }
    } else if (FileSystemEntity.isDirectorySync(f.path)) {
      out[key] = getFileMap(new Directory(f.path));
    }
  }
  return out;
}