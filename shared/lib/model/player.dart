part of model;

@Typescript()
@JsonSerializable()
class Player {
  String id;
  Map<Lang, String> name;
  String team;
  PlayerHandler handler;
  String color;


  static Player fromJson(Map json) {
    utils.retypeMapInJsonToStringDynamic(json, ["name"]);
    return _$PlayerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PlayerToJson(this);
  }
}

@Typescript()
enum PlayerHandler {
  @JsonValue('firstHuman')
  firstHuman,
  @JsonValue('ai')
  ai,
  @JsonValue('passive')
  passive,
  @JsonValue('everyHuman')
  everyHuman,
}
