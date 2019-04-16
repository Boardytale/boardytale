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

  String get name => isHumanPlayer ? humanPlayer.name : aiGroup.langName.values.first;

  static Player fromJson(Map json) {
    return _$PlayerFromJson(json);
  }

  int getStageColor() {
    var color = ColorParser(this.color);
    return 256 * 256 * 256 * 255 + 256 * 256 * color.red + 256 * color.green + color.blue;
  }

  Map<String, dynamic> toJson() {
    return _$PlayerToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class HumanPlayer {
  String name;
  bool isGameMaster = false;
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
  AiEngine aiEngine;

  static AiGroup fromJson(Map<String, dynamic> json) {
    utils.retypeMapInJsonToStringDynamic(json, ["langName"]);
    return _$AiGroupFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AiGroupToJson(this);
  }
}

@Typescript()
enum AiEngine {
  @JsonValue('passive')
  passive,
  @JsonValue('standard')
  standard,
  @JsonValue('panic')
  panic,
}
