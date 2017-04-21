import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path_lib;

main([args]) {
  if (args is List && args.isNotEmpty && args.first is String) {
    String path = args.first;
    FileSystemEntityType type = FileSystemEntity.typeSync(path);

    print(type);
    if (type == FileSystemEntityType.FILE) {
      File file = new File(path);
      renderByFile(file);
    }
    if (type == FileSystemEntityType.DIRECTORY) {
      Directory dir = new Directory(path);
      for (FileSystemEntity entity in dir.listSync(recursive: false)) {
        type = FileSystemEntity.typeSync(entity.path);
        if (type == FileSystemEntityType.FILE) {
          File file = new File(entity.path);
          if (file.path.contains(".json")) {
            renderByFile(file);
          }
        }
      }
    }
  } else {
    throw "first argument must be path to json file";
  }
}

void renderByFile(File file) {
  String content = file.readAsStringSync();
  String path = path_lib.basename(file.path);
  Map classModel = JSON.decode(content);
  String className = path.replaceAll(".json", "");
  className = className.substring(0, 1).toUpperCase() + className.substring(1);
  String output = """part of model;
    class $className{
    """;

  String getters = "";
  String setters = "";
  String fromMap = "void fromMap(Map data){\n";
  String toMap = "Map toMap(){\nMap out = {};";

  classModel.forEach((k, v) {
    String dataType = v.runtimeType.toString();
    String value = "";
    if (v is List && v.isNotEmpty && v.first is String) {
      dataType = "List<${v.first}>";
      value += "= new List<${v.first}>()";
    }else{
      setters += "set $k($dataType val){\n  _$k = val;\n onChange.notify();\n}";
      fromMap += """
        dynamic __$k = data["$k"];
        if(__$k is $dataType){
          _$k = __$k;
        }else{
          _badData("$k");
        }
      """;
      toMap += """
        out["$k"] = _$k;
      """;
    }
    output += "$dataType _$k $value;\n";
    getters += "$dataType get $k => _$k;\n";
  });

  output += "Notificator onChange = new Notificator();";

  output += getters;
  output += setters;

  output += fromMap + "\n}";
  output += toMap + "return out;\n}";

  output += r"""
     void _badData(String key){
       throw "key $key is in bad";
     }
  }""";

  String outputFilePath = file.path.replaceAll("json", "dart");
  File outputFile = new File(outputFilePath);
  outputFile.writeAsStringSync(output);
  ProcessResult result = Process.runSync("dartfmt.bat", [outputFilePath]);
  outputFile.writeAsStringSync(result.stdout.toString());
  print(output);
}