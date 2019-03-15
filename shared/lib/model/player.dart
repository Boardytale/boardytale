part of model;

@Typescript()
@JsonSerializable()
class Player {
  @TypescriptOptional()
  String id;
  String taleId;
  String team = "0";
  String color;
  @TypescriptOptional()
  HumanPlayer humanPlayer;
  @TypescriptOptional()
  AiGroup aiGroup;

  get isHumanPlayer => humanPlayer != null;

  get isAiPlayer => aiGroup != null;

  get isGameMaster => isHumanPlayer && humanPlayer.isGameMaster;

  String get name => isHumanPlayer?humanPlayer.name: aiGroup.langName.values.first;

  static Player fromJson(Map json) {
    return _$PlayerFromJson(json);
  }

  int getStageColor() {
    var color = ColorParser(this.color);
    return int.parse(
        "0xFF${color.red.toRadixString(16)}${color.green.toRadixString(16)}${color.blue.toRadixString(16)}");
  }

  Map<String, dynamic> toJson() {
    return _$PlayerToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class HumanPlayer {
  String name;
  bool isGameMaster;
  Image portrait;

  static HumanPlayer fromJson(Map<String, dynamic> json) {
    return _$HumanPlayerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HumanPlayerToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class AiGroup {
  Map<Lang, String> langName;

  static AiGroup fromJson(Map<String, dynamic> json) {
    utils.retypeMapInJsonToStringDynamic(json, ["langName"]);
    return _$AiGroupFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AiGroupToJson(this);
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
