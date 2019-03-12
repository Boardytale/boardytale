part of model;

@Typescript()
@JsonSerializable()
class Player {
  Image portrait;
  String id;
  String name;
  String team;
  int color;
  bool gameMaster;

  String getHtmlColor() {
    return "rgba($red, $green,$blue,$alpha)";
  }

  int get alpha => (0xff000000 & color) >> 24;

  int get blue => (0x000000ff & color) >> 0;

  int get green => (0x0000ff00 & color) >> 8;

  int get red => (0x00ff0000 & color) >> 16;

  static Player fromJson(Map json) {
    return _$PlayerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PlayerToJson(this);
  }
}

//@Typescript()
//enum PlayerHandler {
//  @JsonValue('firstHuman')
//  firstHuman,
//  @JsonValue('ai')
//  ai,
//  @JsonValue('passive')
//  passive,
//  @JsonValue('everyHuman')
//  everyHuman,
//}
