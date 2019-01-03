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
    final query = Query<Image>(context)
      ..values.imageType = image.type
      ..values.authorEmail = image.authorEmail
      ..values.imageDataVersion = image.dataModelVersion
      ..values.imageData = Document(image.toJson());
    Image created = await query.insert();
    return Response.ok(created);
  }
}

class ImageWrap extends model.Image implements Serializable {
  @override
  Map<String, dynamic> asMap() {
    return super.toJson();
  }

  @override
  void readFromMap(Map<String, dynamic> requestBody) {
    super.fromJson(requestBody);
  }

  @override
  APISchemaObject documentSchema(APIDocumentContext context) {
    return null;
  }
}
