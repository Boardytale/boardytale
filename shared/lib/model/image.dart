part of model;

@JsonSerializable(nullable: false)
class Image {
  String id;
  String data;
  String imageSrc;
  double multiply = 1.0;
  int width;
  int height;
  int top = 0; // option to possible make smaller images
  int left = 0;
  String name;
  ImageType type;
  String authorEmail;
  final int dataModelVersion = 0;

  /// The place where the image comes from. Expected is URL or just "direct"
  String origin;
  String parentId;
  bool published = false;
  DateTime created;
  List<String> tags;

  void fromJson(Map<String, dynamic> json) {
    _$ImageFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ImageToJson(this);
  }
}

class Images {
  static Map<String, Image> images = {};

  void fromMap(Map data) {
    data.forEach((dynamic id, dynamic image) {
      images[id] = new Image()..fromJson(image);
    });
  }
}

enum ImageType { field, unitIcon, unitBase, unitHighRes, item, taleFullScreen, taleBottomScreen }
