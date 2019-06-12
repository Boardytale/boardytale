part of model;

@Typescript()
abstract class UnitTypeCommons {
  String name;
  Races race;
  List<UnitTypeTag> tags;
  int health;
  int armor;
  int speed;
  int range;
  int actions;
  String attack;
  int cost;
  Map<Lang, String> langName;
  int unitTypeDataVersion = 0;
  int unitTypeVersion = 0;
}

@Typescript()
@JsonSerializable()
class UnitTypeCompiled extends UnitTypeCommons {
  AbilitiesEnvelope abilities;
  String authorEmail;
  Image image;
  Image icon;
  Image bigImage;

  static UnitTypeCompiled fromJson(Map<String, dynamic> data) {
    utils.retypeMapInJsonToStringDynamic(data, ["langName"]);
    return _$UnitTypeCompiledFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitTypeCompiledToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class UnitType extends UnitTypeCommons {
  String imageName;
  String iconName;
  String bigImageName;
  AbilitiesEnvelope abilities;

  fromCompiled(UnitTypeCompiled data, Assets assets) {
    abilities = data.abilities;
    imageName = data.image.name;
    bigImageName = data.bigImage?.name;
    iconName = data.icon?.name;
    race = data.race;
    name = data.name;
    health = data.health;
    armor = data.armor;
    speed = data.speed;
    range = data.range;
    actions = data.actions;
    attack = data.attack;
    cost = data.cost;
    assets.images[data.image.name] = data.image;
    if (data.bigImage != null) {
      assets.images[data.bigImage.name] = data.bigImage;
    }
    if (data.icon != null) {
      assets.images[data.icon.name] = data.icon;
    }
  }

  static UnitType fromJson(Map data) {
    return _$UnitTypeFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitTypeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class UnitTypeEnvelope extends UnitType {
  String authorEmail;
  String created;

  static UnitTypeEnvelope fromJson(Map data) {
    return _$UnitTypeEnvelopeFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitTypeEnvelopeToJson(this);
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
