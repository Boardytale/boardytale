import 'package:aqueduct/aqueduct.dart';
import 'dart:convert';

import 'package:core/model/model.dart';

class IdWrap implements Serializable {
  String id;

  @override
  Map<String, dynamic> asMap() {
    return {"id": id};
    // TODO: implement asMap
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    id = requestBody["id"] as String;
  }

  void read(Map<String, dynamic> object, {Iterable<String> ignore, Iterable<String> reject, Iterable<String> require}) {
    readFromMap(object);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    // TODO: implement documentSchema
    return null;
  }

  static String packId(String id) {
    return json.encode((IdWrap()..id = id).asMap());
  }
}

class NameWrap implements Serializable {
  String name;

  @override
  Map<String, dynamic> asMap() {
    return {"name": name};
    // TODO: implement asMap
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    name = requestBody["name"] as String;
  }

  void read(Map<String, dynamic> object, {Iterable<String> ignore, Iterable<String> reject, Iterable<String> require}) {
    readFromMap(object);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    // TODO: implement documentSchema
    return null;
  }

  static String packName(String name) {
    return json.encode((NameWrap()..name = name).asMap());
  }
}

class RenameWrap implements Serializable {
  String name;
  String innerToken;

  @override
  Map<String, dynamic> asMap() {
    return {"name": name, "innerToken": innerToken};
    // TODO: implement asMap
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    name = requestBody["name"] as String;
    innerToken = requestBody["innerToken"] as String;
  }

  void read(Map<String, dynamic> object, {Iterable<String> ignore, Iterable<String> reject, Iterable<String> require}) {
    readFromMap(object);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    // TODO: implement documentSchema
    return null;
  }

  static String packRename(String name, String innerToken) {
    return json.encode((RenameWrap()
          ..name = name
          ..innerToken = innerToken)
        .asMap());
  }
}


class ToUserServerMessageWrap implements Serializable {
  ToUserServerMessage message;

  @override
  Map<String, dynamic> asMap() {
    return message.toJson();
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    message = ToUserServerMessage.fromJson(requestBody);
  }

  void read(Map<String, dynamic> object, {Iterable<String> ignore, Iterable<String> reject, Iterable<String> require}) {
    readFromMap(object);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    // TODO: implement documentSchema
    return null;
  }

}
