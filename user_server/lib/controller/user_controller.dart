import 'dart:async';

import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/model/user.dart';
import 'package:http/http.dart' as http;

class UserController extends ResourceController {
  UserController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> login(@Bind.body() IdWrap note) async {
    http.Response response = await http.get('https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=${note.id}');
    print(response.body);
    return Response.ok(response.body);
  }
}

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

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    // TODO: implement documentSchema
    return null;
  }
}