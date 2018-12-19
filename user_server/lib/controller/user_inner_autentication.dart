import 'dart:async';
import 'dart:convert';

import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class UserController extends ResourceController {
  UserController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> getUserByInnerToken(@Bind.body() InnerTokenWrap innerTokenWrap) async {
    var query = Query<User>(context)..where((u) => u.innerToken).equalTo(innerTokenWrap.innerToken);
    List<User> users = await query.fetch();
    if (users.isEmpty) {
      return Response.notFound();
    } else {
     return Response.ok(users.first.asMap());
    }
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

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    // TODO: implement documentSchema
    return null;
  }
}
