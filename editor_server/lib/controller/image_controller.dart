import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:editor_server/model/image.dart';
import 'package:core/model/model.dart' as core;

class ImageController extends ResourceController {
  ImageController(this.context);

  final ManagedContext context;

  @Operation.get('type')
  Future<Response> getImageByType() async {
    dynamic _type = request.path.variables['type'];
    core.ImageType imageType;
    if (_type is core.ImageType) {
      imageType = _type;
    } else {
      return Response.badRequest(
          body: {'error': 'image type not sent or not supported see ImageType for more details'});
    }
    var query = Query<Image>(context)..where((u) => u.imageType).equalTo(imageType);
    List<Image> result = await query.fetch();
    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> createImage(@Bind.body() ImageWrap imageWrap) async {
    core.Image image = imageWrap.content;
    final query = Query<Image>(context)
      ..where((i) {
        return i.name;
      }).equalTo(image.name);
    List<Image> existingImages = await query.fetch();
    if (existingImages.isEmpty) {
      final query = Query<Image>(context)
        ..values.name = image.name
        ..values.imageType = image.type
        ..values.authorEmail = image.authorEmail
        ..values.imageDataVersion = image.dataModelVersion
        ..values.imageVersion = image.imageVersion
        ..values.imageData = Document(image.toJson());
      Image created = await query.insert();
      return Response.ok(created);
    } else {
      query
        ..values.name = image.name
        ..values.imageType = image.type
        ..values.authorEmail = image.authorEmail
        ..values.imageDataVersion = image.dataModelVersion
        ..values.imageVersion = image.imageVersion
        ..values.imageData = Document(image.toJson());
      Image created = await query.updateOne();
      return Response.ok(created);
//      return Response.conflict(body: "image name is alredy used");
    }
  }
}

class ImageWrap implements Serializable {
  core.Image content;

  @override
  Map<String, dynamic> asMap() {
    return content.toJson();
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    content = core.Image.fromJson(requestBody);
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
