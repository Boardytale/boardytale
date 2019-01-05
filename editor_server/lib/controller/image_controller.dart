import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:editor_server/model/image.dart';
import 'package:shared/model/model.dart' as model;

class ImageController extends ResourceController {
  ImageController(this.context);

  final ManagedContext context;

  @Operation.get('type')
  Future<Response> getImageByType() async {
    dynamic _type = request.path.variables['type'];
    model.ImageType imageType;
    if (_type is model.ImageType) {
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
    model.Image image = imageWrap.content;
    dynamic _id = image.id;
    if (_id is String) {
      final query = Query<Image>(context)..where((i) => i.id).equalTo(_id);
      List<Image> existingImages = await query.fetch();
      if (existingImages.isEmpty) {
        final query = Query<Image>(context)
          ..values.id = _id
          ..values.imageType = image.type
          ..values.authorEmail = image.authorEmail
          ..values.imageDataVersion = image.dataModelVersion
          ..values.imageData = Document(image.toJson());
        Image created = await query.insert();
        return Response.ok(created);
      } else {
        return Response.conflict(body: "image id is used");
      }
    } else {
      return Response.badRequest(body: "image id must be specified as a String");
    }

  }
}

class ImageWrap implements Serializable {
  model.Image content;

  @override
  Map<String, dynamic> asMap() {
    return content.toJson();
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    content = model.Image.fromJson(requestBody);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    return null;
  }
}
