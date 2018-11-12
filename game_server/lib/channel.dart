import 'dart:io';
import 'dart:async';

import 'package:aqueduct/aqueduct.dart';
import 'package:http/http.dart' as http;


class MyConfiguration extends Configuration {
  MyConfiguration() : super.fromFile(File("config.yaml"));

  DatabaseConfiguration database;
}

class BoardyTaleChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final ManagedDataModel dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final config = MyConfiguration();
    final PostgreSQLPersistentStore psc = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username, config.database.password, config.database.host, config.database.port, config.database.databaseName);

    context = ManagedContext(dataModel, psc);

//    final query = Query<Author>(context)
//      ..values.lastName = 'Last'
//      ..values.firstName = 'First';
//    final result = await query.insert();
//    print(result.firstName);
//    print(result.lastName);
//    print(result.id);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/files/*").link(() => FileController("public/", onFileNotFound: (controller, req) async {
      return Response.ok(File("public/index.html").readAsStringSync(), headers: {"content-type": "text/html"});
    }));

    router.route("/example").link(() => MyController());
    router.route("/authors").linkFunction((request) async {
      return Response.ok({"key": "aa"});
    });

    return router;
  }
}

class MyController extends ResourceController {
  @Operation.post()
  Future<Response> createNote(@Bind.body() IdWrap note) async {
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
  }
}
