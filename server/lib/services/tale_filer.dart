import 'dart:convert';
import 'dart:io';
import 'package:boardytale_commons/model/model.dart';
import 'package:boardytale_server/model/model.dart';
import 'package:boardytale_server/server.dart';
import 'package:io_utils/io_utils.dart';
import 'package:tales_compiler/tales_compiler.dart';

void compileTales() {
  Map<String, dynamic> fileMap = getFileMap(new Directory(pathToData));
  InstanceGenerator generator = new ServerInstanceGenerator();
  Resources allResources = getResourcesFromFileMap(fileMap, generator);
  Map<String, Tale> tales = loadTales(fileMap,allResources);

  tales.forEach((k, v) {
    new File("web/tales/${v.id}.json").writeAsStringSync(JSON.encode(TaleAssetsPack.pack(v,allResources)));
  });
}

String loadTaleData(String name) {
  return new File("web/tales/${name}.json").readAsStringSync();
}
