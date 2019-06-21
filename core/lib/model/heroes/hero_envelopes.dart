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
class HeroEnvelope implements ItemManipulable{
  GameHeroEnvelope gameHeroEnvelope;
  List<ItemEnvelope> inventoryItems = [];
  /// for hero creation
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  Map<ItemPosition, String> equippedItemNames;
  /// compiled
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  Map<ItemPosition, ItemEnvelope> equippedItems;
  int strength = 1;
  int agility = 1;
  int intelligence = 1;
  int precision = 10;
  int spirituality = 10;
  int energy = 10;
  int experience = 0;
  int money = 100;

  static HeroEnvelope fromJson(Map<String, dynamic> json){
    utils.retypeMapInJsonToStringDynamic(json, ["equippedItems", "equippedItemNames"]);
    return _$HeroEnvelopeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HeroEnvelopeToJson(this);
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
  int strength;
  int agility;
  int intelligence;
  int precision;
  int spirituality;
  int energy;
  int pickGainId;
  List<ItemManipulation> itemManipulations = [];
  HeroEnvelope responseHero;

  static HeroUpdate fromJson(Map<String, dynamic> json) => _$HeroUpdateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$HeroUpdateToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class ItemManipulation {
  String equipItemId;
  ItemPosition equipTo;
  String moveToInventoryItemId;
  String sellItemId;

  static ItemManipulation fromJson(Map<String, dynamic> json) => _$ItemManipulationFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ItemManipulationToJson(this);
  }
}


@Typescript()
@JsonSerializable()
class HeroAfterGameGain {
  int id;
  int xp;
  int money;
  List<String> itemTypeNames;
  String heroId;

  static HeroAfterGameGain fromJson(Map<String, dynamic> json) => _$HeroAfterGameGainFromJson(json);

  Map<String, dynamic> toJson() {
    return _$HeroAfterGameGainToJson(this);
  }
}
