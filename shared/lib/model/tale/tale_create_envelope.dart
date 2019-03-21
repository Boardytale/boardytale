part of model;

@Typescript()
@JsonSerializable()
class TaleCreateEnvelope {
  String authorEmail;
  TaleInnerEnvelope tale;
  LobbyTale lobby;

  final int taleDataVersion = 0;

  Map toJson() {
    return _$TaleCreateEnvelopeToJson(this);
  }

  static TaleCreateEnvelope fromJson(Map<String, dynamic> json) {
    return _$TaleCreateEnvelopeFromJson(json);
  }
}

@Typescript()
@JsonSerializable()
class TaleCompiled {
  String authorEmail;
  TaleInnerCompiled tale;
  LobbyTale lobby;

  final int taleDataVersion = 0;

  Map toJson() {
    return _$TaleCompiledToJson(this);
  }

  static TaleCompiled fromJson(Map<String, dynamic> json) {
    return _$TaleCompiledFromJson(json);
  }
}

@Typescript()
@JsonSerializable()
class TaleInnerEnvelope {
  String name;
  Map<Lang, String> langName;
  Map<Lang, Map<String, String>> langs;
  int taleVersion;
  List<Team> teams = [];
  WorldCreateEnvelope world;
  Map<String, Player> aiPlayers = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  List<UnitCreateEnvelope> units = [];
  List<String> humanPlayerIds = [];

  static TaleInnerEnvelope fromJson(Map json) {
    return _$TaleInnerEnvelopeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TaleInnerEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class TaleInnerCompiled {
  String name;
  Map<Lang, Map<String, String>> langs;
  Map<Lang, String> langName;
  int taleVersion;
  WorldCreateEnvelope world;
  Map<String, Player> aiPlayers = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  List<UnitCreateEnvelope> units = [];
  List<String> humanPlayerIds = [];
  TaleCompiledAssets assets;

  static TaleInnerCompiled fromJson(Map json) {
    utils.retypeMapInJsonToStringDynamic(json, ["langs", "langName"]);
    return _$TaleInnerCompiledFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TaleInnerCompiledToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class UnitCreateEnvelope {
  String fieldId;
  String unitTypeName;
  String playerId;
  @TypescriptOptional()
  int health;

  static UnitCreateEnvelope fromJson(Map json) {
    return _$UnitCreateEnvelopeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UnitCreateEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class TaleCompiledAssets {
  Map<String, Image> images = {};
  Map<String, UnitTypeCompiled> unitTypes = {};

  static TaleCompiledAssets fromJson(Map json) {
    return _$TaleCompiledAssetsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TaleCompiledAssetsToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class Team {
  String id;
  List<String> allies;
  List<String> hostiles;
  Map<Lang, String> name;
  String color;

  static Team fromJson(Map<String, dynamic> json) {
    utils.retypeMapInJsonToStringDynamic(json, ["name"]);
    return _$TeamFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TeamToJson(this);
  }
}
