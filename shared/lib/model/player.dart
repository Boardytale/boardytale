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
