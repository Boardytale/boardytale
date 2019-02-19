import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:editor_server/model/image.dart';
import 'package:shared/model/model.dart' as shared;

class ImageController extends ResourceController {
  ImageController(this.context);

  final ManagedContext context;

  @Operation.get('type')
  Future<Response> getImageByType() async {
    dynamic _type = request.path.variables['type'];
    shared.ImageType imageType;
    if (_type is shared.ImageType) {
      imageType = _type;
    } else {
      return Response.badRequest(body: {
        'error':
            'image type not sent or not supported see ImageType for more details'
      });
    }
    var query = Query<Image>(context)
      ..where((u) => u.imageType).equalTo(imageType);
    List<Image> result = await query.fetch();
    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> createImage(@Bind.body() ImageWrap imageWrap) async {
    shared.Image image = imageWrap.content;
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
      return Response.conflict(body: "image name is alredy used");
    }
  }
}

class ImageWrap implements Serializable {
  shared.Image content;

  @override
  Map<String, dynamic> asMap() {
    return content.toJson();
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    content = shared.Image.fromJson(requestBody);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    return null;
  }
}
