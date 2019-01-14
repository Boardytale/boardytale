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
  Map<Lang, Map<String, String>> langs;
  int taleVersion;
  WorldCreateEnvelope world;
  Map<String, Player> players = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  Map<String, String> units = {};

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
  int taleVersion;
  WorldCreateEnvelope world;
  Map<String, Player> players = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  Map<String, String> units = {};
  TaleCompiledAssets assets;

  static TaleInnerCompiled fromJson(Map json) {
    return _$TaleInnerCompiledFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TaleInnerCompiledToJson(this);
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