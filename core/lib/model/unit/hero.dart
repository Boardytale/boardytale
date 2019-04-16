part of model;

@JsonSerializable()
class GameHeroCreateEnvelope {
  int level;
  String name;
  UnitTypeCompiled type;
  UnitCreateOrUpdateAction unit;

  static GameHeroCreateEnvelope fromJson(Map<String, dynamic> json) =>
      _$GameHeroCreateEnvelopeFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GameHeroCreateEnvelopeToJson(this);
  }
}
