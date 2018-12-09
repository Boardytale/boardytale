import 'dart:async';
import 'dart:convert';

import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class UserController extends ResourceController {
  UserController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> login(@Bind.body() IdWrap note) async {
    print("prepared");
    print('https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=${note.id}');
    http.Response response = await http.get('https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=${note.id}');
    print(response.body);

    Map userdata = json.decode(response.body);

    // check if exist
    if (userdata.containsKey("email") && userdata["email"] is String) {
      String innerToken = uuid.v4();
      var query = Query<User>(context)..where((u) => u.email).equalTo(userdata["email"] as String);
      if ((await query.fetch()).isEmpty) {
        // create new user
        User newUser = User()
          ..email = userdata["email"] as String
          ..innerToken = innerToken;
        newUser = await (Query<User>(context)..values = newUser).insert();
        return Response.ok(newUser.asMap());
      } else {
        // save token
        List<User> users = await (Query<User>(context)
              ..values.innerToken = innerToken
              ..where((u) => u.email).equalTo(userdata["email"] as String))
            .update();
        if (users.isNotEmpty) {
          return Response.ok(users.first.asMap());
        } else {
          return Response.serverError(body: "Unable to get user from database");
        }
      }
    } else {
      return Response.serverError(body: "Unable to contact Authorization server");
    }
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
