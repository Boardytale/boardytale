part of model;

@Typescript()
@JsonSerializable()
class PlayerBase {
//  String id;
//  Map<Lang, String> name;
  Image portrait;

  static PlayerBase fromJson(Map json) {
    return _$PlayerBaseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PlayerBaseToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class LobbyPlayer extends PlayerBase {
  bool lobbyMaster;
  String name;

  static LobbyPlayer fromJson(Map json) {
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
//  PlayerHandler handler;
  String color;

  static TalePlayer fromJson(Map json) {
    return _$TalePlayerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TalePlayerToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class GamePlayer extends TalePlayer {
  String id;
  static GamePlayer fromJson(Map json) {
    return _$GamePlayerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GamePlayerToJson(this);
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
