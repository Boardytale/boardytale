part of model;

@Typescript()
@JsonSerializable()
class GameHeroEnvelope {
  @TypescriptOptional()
  String id;
  int level;
  String name;
  UnitTypeCompiled type;
  @JsonKey(includeIfNull: false)
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
  /// for hero creation
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  EquippedItemNames equippedItemNames;
  /// compiled
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  EquippedItemsEnvelope equippedItems;
  num strength = 1;
  int agility = 1;
  num intelligence = 1;
  num precision = 10;
  num spirituality = 10;
  num energy = 10;
  num experience = 0;
  num money = 100;

  static HeroEnvelope fromJson(Map<String, dynamic> json){
    utils.retypeMapInJsonToStringDynamic(json, ["equippedItems"]);
    return _$HeroEnvelopeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HeroEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class EquippedItemsEnvelope {
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemEnvelope head;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemEnvelope neck;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemEnvelope body;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemEnvelope elbows;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemEnvelope leftHand;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemEnvelope rightHand;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemEnvelope leftWrist;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemEnvelope rightWrist;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemEnvelope legs;

  List<ItemEnvelope> equippedItemsList() {
    return [head, neck, body, elbows, leftHand, rightHand, leftWrist, rightWrist, legs].where((item) {
      return item != null;
    }).toList();
  }

  static EquippedItemsEnvelope fromJson(Map<String, dynamic> json) => _$EquippedItemsEnvelopeFromJson(json);

  Map<String, dynamic> toJson() {
    return _$EquippedItemsEnvelopeToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class EquippedItemNames {
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String head;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String neck;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String body;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String elbows;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String leftHand;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String rightHand;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String leftWrist;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String rightWrist;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String legs;

  static EquippedItemNames fromJson(Map<String, dynamic> json) => _$EquippedItemNamesFromJson(json);

  Map<String, dynamic> toJson() {
    return _$EquippedItemNamesToJson(this);
  }
}

@Typescript()
enum ItemPosition {
  @JsonValue('head')
  head,
  @JsonValue('neck')
  neck,
  @JsonValue('body')
  body,
  @JsonValue('elbows')
  elbows,
  @JsonValue('leftHand')
  leftHand,
  @JsonValue('rightHand')
  rightHand,
  @JsonValue('leftWrist')
  leftWrist,
  @JsonValue('rightWrist')
  rightWrist,
  @JsonValue('legs')
  legs,
  @JsonValue('bothHands')
  bothHands,
}

@Typescript()
@JsonSerializable()
class HeroUpdate {
  String heroId;
  String name;
  num strength;
  int agility;
  num intelligence;
  num precision;
  num spirituality;
  num energy;
  int pickGainId;
  String equipItemId;
  ItemPosition equipTo;
  String moveToInventoryItemId;
  String sellItemId;
  String buyItemId;
  HeroEnvelope responseHero;

  static HeroUpdate fromJson(Map<String, dynamic> json) => _$HeroUpdateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$HeroUpdateToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class HeroAfterGameGain {
  int id;
  int xp;
  int money;
  List<String> itemIds;
  String heroId;

  static HeroAfterGameGain fromJson(Map<String, dynamic> json) => _$HeroAfterGameGainFromJson(json);

  Map<String, dynamic> toJson() {
    return _$HeroAfterGameGainToJson(this);
  }
}
