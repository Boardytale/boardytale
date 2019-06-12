import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:editor_server/model/image.dart';
import 'package:editor_server/model/unit.dart';
import 'package:core/model/model.dart' as model;
import 'package:io_utils/aqueduct/wraps.dart';

class UnitController extends ResourceController {
  UnitController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getUnitByName(@Bind.path("id") String name) async {
    if (name == null) {
      return Response.badRequest(body: "id is not provided");
    }
    var query = Query<UnitType>(context)..where((u) => u.name).equalTo(name)..where((u) => u.compiled).equalTo(true);
    List<UnitType> result = await query.fetch();
    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> createUnit(@Bind.body() UnitWrap unitWrap) async {
    final query = Query<UnitType>(context)
      ..where((i) {
        return i.name;
      }).equalTo(unitWrap.content.name);
    List<UnitType> existingImages = await query.fetch();
    if (existingImages.isEmpty) {
      model.UnitTypeEnvelope content = unitWrap.content;
      final query = Query<UnitType>(context)
        ..values.name = content.name
        ..values.authorEmail = content.authorEmail
        ..values.unitTypeDataVersion = content.unitTypeDataVersion
        ..values.unitTypeVersion = content.unitTypeVersion
        ..values.unitTypeData = Document(content.toJson());
      UnitType created = await query.insert();
      return Response.ok(created);
    } else {
      model.UnitTypeEnvelope content = unitWrap.content;
      query
        ..values.name = content.name
        ..values.authorEmail = content.authorEmail
        ..values.unitTypeDataVersion = content.unitTypeDataVersion
        ..values.unitTypeVersion = content.unitTypeVersion
        ..values.unitTypeData = Document(content.toJson());
      UnitType created = await query.updateOne();
      return Response.ok(created);
//      return Response.conflict(body: "unit name is alredy used");
    }
  }

  @Operation.post('operation')
  Future<Response> compileUnit(@Bind.body() IdWrap idWrap) async {
    print("compile unit");
    var notCompiledQuery = Query<UnitType>(context)
      ..where((u) => u.name).equalTo(idWrap.id)
      ..where((u) => u.compiled).equalTo(false);

    var compiledQuery = Query<UnitType>(context)
      ..where((u) => u.name).equalTo('${idWrap.id}Compiled')
      ..where((u) => u.compiled).equalTo(true);

    UnitType unitTypeData = (await notCompiledQuery.fetch()).first;

    // get images
    var unitTypeEnvelope = model.UnitTypeEnvelope.fromJson(unitTypeData.unitTypeData.data as Map);

    model.Image image;
    model.Image icon;
    model.Image bigImage;

    var query = Query<Image>(context)..where((u) => u.name).equalTo(unitTypeEnvelope.imageName);
    List<Image> result = await query.fetch();
    if (result.isNotEmpty) {
      image = model.Image.fromJson(result.first.imageData.data as Map<String, dynamic>);
    }

    query = Query<Image>(context)..where((u) => u.name).equalTo(unitTypeEnvelope.iconName);
    result = await query.fetch();
    if (result.isNotEmpty) {
      icon = model.Image.fromJson(result.first.imageData.data as Map<String, dynamic>);
    }

    query = Query<Image>(context)..where((u) => u.name).equalTo(unitTypeEnvelope.bigImageName);
    result = await query.fetch();
    if (result.isNotEmpty) {
      bigImage = model.Image.fromJson(result.first.imageData.data as Map<String, dynamic>);
    }

    model.UnitTypeCompiled unitType = model.UnitTypeCompiled.fromJson(unitTypeData.unitTypeData.data as Map<String, dynamic>);
    unitType
      ..image = image
      ..bigImage = bigImage
      ..icon = icon;
    compiledQuery.values
      ..compiled = true
      ..authorEmail = unitType.authorEmail
      ..name = '${idWrap.id}Compiled'
      ..unitTypeData = Document(unitType.toJson());

    UnitType created;
    var compiled = await compiledQuery.fetch();
    if (compiled.isNotEmpty) {
      created = (await compiledQuery.update()).first;
    } else {
      created = await compiledQuery.insert();
    }
    return Response.ok(created);
  }
}

class UnitWrap implements Serializable {
  model.UnitTypeEnvelope content;

  @override
  Map<String, dynamic> asMap() {
    return content.toJson();
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    content = model.UnitTypeEnvelope.fromJson(requestBody);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    return null;
  }
  @override
  void read(Map<String, dynamic> object, {Iterable<String> ignore, Iterable<String> reject, Iterable<String> require}) {
    readFromMap(object);
  }
}
