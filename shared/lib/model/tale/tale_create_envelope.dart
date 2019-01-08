part of model;

@Typescript()
@JsonSerializable()
class TaleCreateEnvelope {
  String authorEmail;
  TaleInnerEnvelope tale;
  LobbyTale lobby;

  final int taleDataVersion = 0;

  static TaleCreateEnvelope fromJson(Map<String, dynamic> json) {
    return _$TaleCreateEnvelopeFromJson(json);
  }
}

@Typescript()
@JsonSerializable()
class TaleInnerEnvelope{
  String id;
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