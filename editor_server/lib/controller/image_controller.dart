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
  Future<Response> createImage(@Bind.body() ImageWrap image) async {
    print("create image");
    final query = Query<Image>(context)
      ..values.imageType = image.content.type
      ..values.authorEmail = image.content.authorEmail
      ..values.imageDataVersion = image.content.dataModelVersion
      ..values.imageData = Document(image.content.toJson());
    Image created = await query.insert();
    return Response.ok(created);
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
