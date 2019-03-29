import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:editor_server/model/tale.dart';
import 'package:editor_server/model/unit.dart';
import 'package:io_utils/aqueduct/wraps.dart';
import 'package:shared/model/model.dart' as shared;

class TaleController extends ResourceController {
  TaleController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getTaleById(@Bind.path("id") String id) async {
    if (id == null) {
      return Response.badRequest(body: "id is not provided");
    }
    var query = Query<Tale>(context)..where((u) => u.id).equalTo(id);
    List<Tale> result = await query.fetch();
    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> createTale(@Bind.body() TaleWrap taleWrap) async {
    final query = Query<Tale>(context)
      ..where((i) {
        return i.name;
      }).equalTo(taleWrap.content.tale.name);
    List<Tale> existingTale = await query.fetch();
    var lobbyTale = taleWrap.content.lobby;
    var tale = taleWrap.content.tale;
    if (existingTale.isEmpty) {
      final query = Query<Tale>(context)
        ..values.name = tale.name
        ..values.authorEmail = taleWrap.content.authorEmail
        ..values.taleDataVersion = taleWrap.content.taleDataVersion
        ..values.lobbyTale = Document(lobbyTale.toJson())
        ..values.taleData = Document(tale.toJson());
      Tale created = await query.insert();
      return Response.ok(created);
    } else {
      query
        ..values.name = tale.name
        ..values.authorEmail = taleWrap.content.authorEmail
        ..values.taleDataVersion = taleWrap.content.taleDataVersion
        ..values.lobbyTale = Document(lobbyTale.toJson())
        ..values.taleData = Document(tale.toJson());
      Tale created = await query.updateOne();
      return Response.ok(created);
    }
  }

  @Operation.post('operation')
  Future<Response> compileTale(@Bind.body() IdWrap idWrap) async {
    print("compile tale");
    var notCompiledQuery = Query<Tale>(context)
      ..where((u) => u.name).equalTo(idWrap.id)
      ..where((u) => u.compiled).equalTo(false);

    var compiledQuery = Query<Tale>(context)
      ..where((u) => u.name).equalTo("${idWrap.id}Compiled")
      ..where((u) => u.compiled).equalTo(true);

    Tale taleData = (await notCompiledQuery.fetch()).first;

    // get images
    var taleInnerDataEnvelope = shared.TaleInnerEnvelope.fromJson(taleData.taleData.data as Map<String, dynamic>);

    shared.TaleCompiled taleCompiled = shared.TaleCompiled();
    taleCompiled.authorEmail = taleData.authorEmail;
    taleCompiled.tale = shared.TaleInnerCompiled.fromJson(taleInnerDataEnvelope.toJson());
    taleCompiled.lobby = shared.LobbyTale.fromJson(taleData.lobbyTale.data as Map);

    shared.TaleInnerCompiled innerCompiled = taleCompiled.tale;

    innerCompiled.images = {};
    innerCompiled.unitTypes = {};

    for (var envelope in innerCompiled.units) {
      String unitName = envelope.changeToTypeName;
      var query = Query<UnitType>(context)..where((u) => u.name).equalTo("${unitName}Compiled");
      List<UnitType> result = await query.fetch();
      if (result.isNotEmpty) {
        // compiled unit ready
        innerCompiled.unitTypes[unitName] =
            shared.UnitTypeCompiled.fromJson(result.first.unitTypeData.data as Map<String, dynamic>);
      } else {
        // check if not compiled ready
        var query = Query<UnitType>(context)..where((u) => u.name).equalTo(unitName);
        List<UnitType> result = await query.fetch();
        if (result.isNotEmpty) {
          // compile
          return Response.serverError(body: "unit compilation during tale compilation is not impelemnted yet");
        } else {
          return Response.badRequest(body: "Unit ${unitName} does not exist");
        }
      }
    }

    compiledQuery.values
      ..compiled = true
      ..authorEmail = taleCompiled.authorEmail
      ..name = '${idWrap.id}Compiled'
      ..taleData = Document(taleCompiled.toJson())
      ..lobbyTale = taleData.lobbyTale;

    Tale created;
    var compiled = await compiledQuery.fetch();
    if (compiled.isNotEmpty) {
      created = (await compiledQuery.update()).first;
    } else {
      created = await compiledQuery.insert();
    }
    return Response.ok(created);
  }
}

class TaleWrap implements Serializable {
  shared.TaleCreateEnvelope content;

  @override
  Map<String, dynamic> asMap() {
    return content.lobby.toJson();
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    content = shared.TaleCreateEnvelope.fromJson(requestBody);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    return null;
  }
}
