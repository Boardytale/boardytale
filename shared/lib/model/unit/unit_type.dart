part of model;

abstract class UnitTypeCommons {
  String id;
  Races race;
  List<UnitTypeTag> tags;
  int health;
  int armor;
  int speed;
  int range;
  int actions;
  String attack;
  int cost;
  Abilities abilities;
  Map<Lang, String> unitTypeName;
  int unitTypeDataVersion = 0;
  int unitTypeVersion = 0;
}

@Typescript()
@JsonSerializable()
class UnitTypeCreateEnvelope extends UnitTypeCommons {
  String authorEmail;
  String created;
  String imageId;
  String iconId;
  String bigImageId;

  static UnitTypeCreateEnvelope fromJson(Map data) {
    return _$UnitTypeCreateEnvelopeFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitTypeCreateEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class UnitType extends UnitTypeCommons {
  Image image;
  Image icon;
  Image bigImage;

  static UnitType fromJson(Map data) {
    return _$UnitTypeFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitTypeToJson(this);
  }
}

@Typescript()
enum UnitTypeTag {
  @JsonValue('undead')
  undead,
  @JsonValue('ethernal')
  ethernal,
  @JsonValue('mechanic')
  mechanic,
}
