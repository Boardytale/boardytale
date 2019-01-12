part of model;

@Typescript()
@JsonSerializable(nullable: false)
class Image {
  String id;
  String data;
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
  DateTime created;
  List<ImageTag> tags;

  static Image fromJson(Map<String, dynamic> json) {
    return _$ImageFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ImageToJson(this);
  }
}

class Images {
  static Map<String, Image> images = {};

  void fromMap(Map data) {
    data.forEach((dynamic id, dynamic image) {
      images[id] = Image.fromJson(image);
    });
  }
}

@Typescript()
enum ImageType {
  @JsonValue('field')
  field,
  @JsonValue('unitIcon')
  unitIcon,
  @JsonValue('unitBase')
  unitBase,
  @JsonValue('unitHighRes')
  unitHighRes,
  @JsonValue('item')
  item,
  @JsonValue('taleFullScreen')
  taleFullScreen,
  @JsonValue('taleBottomScreen')
  taleBottomScreen
}

@Typescript()
enum ImageTag {
  @JsonValue('grass')
  grass,
}


