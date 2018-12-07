//import 'dart:io';
//import 'dart:convert';
//import '../mock_storage/gateway.dart';
//
//const String LINE_PREFIX = "export type ";
//
////const List<String> COMPILER_TYPES = const[
////  "AiType",
////  "AnimationType",
////  "ActionType",
////  "EventType",
////  "VariableType",
////  "OperationType",
////  "AttitudeTowardsHumans",
////  "FavouriteControls",
////  "EffectType",
////  "TargetType",
////];
//
//const List<String> ENTITY_TYPES = const [
//  "field",
//  "unitType",
//  "terrain",
//  "ability",
//  "action",
//  "sound",
//  "image",
//  "animation",
//  "ai",
//  "aiPlayer",
//  "dialog",
//  "variable",
//  "member",
//  "race",
//  "buff",
//  "text",
//  "lang",
//];
//
//void main() {
////  File storageIdentifiers = new File("test_storage_identifiers.ts");
//  File storageIdentifiers = new File("lib/template/storage_identifiers.ts");
//  String stringToWrite = "";
//
//  for (String entityType in ENTITY_TYPES) {
//    stringToWrite += "\r";
//    stringToWrite += getEntityTypeLine(entityType);
//  }
//  stringToWrite += "\r";
//  stringToWrite += "\r";
//  Map<String, List<String>> json = JSON.decode(get('compiler_types', 'compiler_types'));
//  List<String> types = json.keys.toList();
//  for (String compilerType in types) {
//    stringToWrite += "\r";
//    stringToWrite += getCompileTypeLine(compilerType, json[compilerType]);
//  }
//
//  if (!storageIdentifiers.existsSync()) {
//    storageIdentifiers.createSync();
//  }
//
//  storageIdentifiers.writeAsStringSync(stringToWrite);
//}
//
//String getCompileTypeLine(String compilerType, List<String> specificTypes) {
//  String toReturn = LINE_PREFIX + "I" + compilerType + " = ";
//  if(specificTypes.isNotEmpty) {
//    toReturn += " '" + specificTypes.first + "'";
//    for (int i = 1; i < specificTypes.length; i++) {
//      toReturn += " | '" + specificTypes[i] + "'";
//    }
//  }
//  else{
//    toReturn += "null";
//  }
//  toReturn += ";";
//  return toReturn;
//}
//
//String getEntityTypeLine(String entityType) {
//  String toReturn = LINE_PREFIX + "I" + entityType.substring(0, 1).toUpperCase() + entityType.substring(1) + "Id = ";
//  List<String> names = getNames(entityType);
//  if (!names.isEmpty) {
//    toReturn += " '" + names.first + "'";
//    for (int i = 1; i < names.length; i++) {
//      toReturn += " | '" + names[i] + "'";
//    }
//  }
//  else{
//    toReturn+="null";
//  }
//  toReturn += ";";
//  return toReturn;
//}
