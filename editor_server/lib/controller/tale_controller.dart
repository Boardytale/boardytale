import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:editor_server/model/tale.dart';
import 'package:shared/model/model.dart' as model;

class TaleController extends ResourceController {
  TaleController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getTaleById(@Bind.path("id") String id) async {
    if(id == null){
      return Response.badRequest(body: "id is not provided");
    }
    var query = Query<Tale>(context)..where((u) => u.id).equalTo(id);
    List<Tale> result = await query.fetch();
    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> createTale(@Bind.body() TaleWrap taleWrap) async {
    var lobbyTale = taleWrap.content.lobby;
    var tale = taleWrap.content.tale;
    final query = Query<Tale>(context)
      ..values.id = tale.id
      ..values.authorEmail = taleWrap.content.authorEmail
      ..values.taleDataVersion = taleWrap.content.taleDataVersion
      ..values.lobbyTale = Document(lobbyTale.toJson())
      ..values.taleData = Document(tale.toJson())
    ;
    Tale created = await query.insert();
    return Response.ok(created);
  }
}

class TaleWrap implements Serializable {
  model.TaleCreateEnvelope content;

  @override
  Map<String, dynamic> asMap() {
    return content.lobby.toJson();
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    content = model.TaleCreateEnvelope.fromJson(requestBody);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    return null;
  }
}
