import 'package:aqueduct/aqueduct.dart';
import 'dart:convert';

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

class InnerTokenWrap implements Serializable {
  String innerToken;

  @override
  Map<String, dynamic> asMap() {
    return {"innerToken": innerToken};
    // TODO: implement asMap
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
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
}


