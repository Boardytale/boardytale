import 'dart:convert';
import 'dart:io';
import 'package:boardytale_commons/model/model.dart';
import 'package:io_utils/io_utils.dart';
import 'package:tales_compiler/tales_compiler.dart';

String pathToData = "../data";

void main(){
  Map fileMap = getFileMap(new Directory(pathToData));
  Map<String, Tale> tales = getTalesFromFileMap(fileMap, new CommonClassGenerator());

  tales.forEach((k,v){
    new File("output/${v.id}.json").writeAsStringSync(JSON.encode(TaleAssetsPack.pack(v)));
  });
}
