part of model;

class PlayerBase {
  String id;
  Map<Lang, String> name;
  Image portrait;
}



@Typescript()
@JsonSerializable()
class LobbyPlayer extends PlayerBase {
  bool lobbyMaster;

  static LobbyPlayer fromJson(Map json) {
    utils.retypeMapInJsonToStringDynamic(json, ["name"]);
    return _$LobbyPlayerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LobbyPlayerToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class TalePlayer extends PlayerBase {
  String team;
  PlayerHandler handler;
  String color;

  static TalePlayer fromJson(Map json) {
    utils.retypeMapInJsonToStringDynamic(json, ["name"]);
    return _$TalePlayerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TalePlayerToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class GamePlayer extends TalePlayer {

  static GamePlayer fromJson(Map json) {
    utils.retypeMapInJsonToStringDynamic(json, ["name"]);
    return _$GamePlayerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GamePlayerToJson(this);
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
