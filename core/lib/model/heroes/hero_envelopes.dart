part of model;

@Typescript()
@JsonSerializable()
class GameHeroEnvelope {
  @TypescriptOptional()
  String id;
  int level;
  String name;
  UnitTypeCompiled type;
  @TypescriptOptional()
  UnitCreateOrUpdateAction unit;

  static GameHeroEnvelope fromJson(Map<String, dynamic> json) => _$GameHeroEnvelopeFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GameHeroEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class HeroEnvelope {
  GameHeroEnvelope gameHeroEnvelope;
  List<ItemEnvelope> inventoryItems = [];
  num strength = 1;
  int agility = 1;
  num intelligence = 1;
  num precision = 10;
  num spirituality = 10;
  num energy = 10;
  num experience = 0;
  num money = 100;

  static HeroEnvelope fromJson(Map<String, dynamic> json) => _$HeroEnvelopeFromJson(json);

  Map<String, dynamic> toJson() {
    return _$HeroEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class ItemEnvelope {
  ItemType itemType;
  String name = "name";
  String id;
  String heroId;
  num weight = 0;
  num armorPoints = 0;
  num healthBonus = 0;
  num manaBonus = 0;
  num strengthBonus = 0;
  num agilityBonus = 0;
  num intelligenceBonus = 0;
  num spiritualityBonus = 0;
  num energyBonus = 0;
  num precisionBonus = 0;
  num suggestedPrice = 100;
  int recommendedPrice = 100;

  static ItemEnvelope fromJson(Map<String, dynamic> json) => _$ItemEnvelopeFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ItemEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class WeaponEnvelope {
  List<int> baseAttack = [0, 0, 0, 0, 0, 0];
  List<int> bonusAttack = [0, 0, 0, 0, 0, 0];

  static WeaponEnvelope fromJson(Map<String, dynamic> json) => _$WeaponEnvelopeFromJson(json);

  Map<String, dynamic> toJson() {
    return _$WeaponEnvelopeToJson(this);
  }
}

@Typescript()
enum ItemType {
  @JsonValue('body')
  body,
  @JsonValue('weapon')
  weapon,
  @JsonValue('helm')
  helm,
  @JsonValue('gauntlet')
  gauntlet,
  @JsonValue('boots')
  boots,
  @JsonValue('ring')
  ring,
  @JsonValue('amulet')
  amulet,
  @JsonValue('shield')
  shield,
}
