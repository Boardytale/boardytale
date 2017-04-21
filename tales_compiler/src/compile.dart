import 'dart:convert';
import 'dart:io';
import 'package:io_utils/io_utils.dart';

String pathToData = "../data";

void main(){
  Map fileMap = getFileMap(new Directory(pathToData));
  print(JSON.encode(fileMap));
  Map images = loadImages(fileMap);
  Map units = loadUnits(fileMap, images);
}

Map loadUnits(Map<String, dynamic> fileMap, Map images) {

}

Map loadImages(Map fileMap) {
  return fileMap["images"];
}