part of model;

class ItemSum {
  double weight = 0;
  int armorPoints = 0;
  int speedPoints = 0;
  int healthBonus = 0;
  int manaBonus = 0;
  int strengthBonus = 0;
  int agilityBonus = 0;
  int intelligenceBonus = 0;
  int spiritualityBonus = 0;
  int precisionBonus = 0;
  int energyBonus = 0;

  void recalculate(List<ItemEnvelope> items) {
    items.forEach((ItemEnvelope item) {
      weight += item.weight;
      armorPoints += item.armorPoints;
      speedPoints += item.speedPoints;

      healthBonus += item.healthBonus;
      manaBonus += item.manaBonus;
      strengthBonus += item.strengthBonus;
      agilityBonus += item.agilityBonus;
      intelligenceBonus += item.intelligenceBonus;

      spiritualityBonus += spiritualityBonus;
      precisionBonus += precisionBonus;
      energyBonus += energyBonus;
    });
  }
}


@Typescript()
@JsonSerializable()
class ItemEnvelope {
  List<ItemPosition> possiblePositions = [];
  String id;
  String name = "name";
  Map<Lang, String> langName;
  String mapImageData;
  String inventoryImageData;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String heroId;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num weight = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num armorPoints = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num speedPoints = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num healthBonus = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num manaBonus = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num strengthBonus = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num agilityBonus = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num intelligenceBonus = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num spiritualityBonus = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num energyBonus = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  num precisionBonus = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 100)
  int recommendedPrice = 100;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  int requiredLevel = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  WeaponEnvelope weapon;

  bool get isWeapon => weapon != null;

  static ItemEnvelope fromJson(Map<String, dynamic> json){
    utils.retypeMapInJsonToStringDynamic(json, ["langName"]);
    return _$ItemEnvelopeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ItemEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class WeaponEnvelope {
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  int requiredStrength = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  int requiredAgility = 0;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  int requiredIntelligence = 0;
  List<int> baseAttack = [0, 0, 0, 0, 0, 0];
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: [0, 0, 0, 0, 0, 0])
  List<int> bonusAttack = [0, 0, 0, 0, 0, 0];
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 0)
  int range = 0;
  static WeaponEnvelope fromJson(Map<String, dynamic> json) => _$WeaponEnvelopeFromJson(json);

  Map<String, dynamic> toJson() {
    return _$WeaponEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class ItemDrops {
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 1)
  int maxItemDrops = 1;
  List<ItemDrop> items = [];
  static ItemDrops fromJson(Map<String, dynamic> json) => _$ItemDropsFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ItemDropsToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class ItemDrop {
  @TypescriptOptional()
  @JsonKey(includeIfNull: false, defaultValue: 1)
  double probability = 1;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String byName;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  int byItemPriceFrom;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  int byItemPriceTo;

  static ItemDrop fromJson(Map<String, dynamic> json) => _$ItemDropFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ItemDropToJson(this);
  }
}
