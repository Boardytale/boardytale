part of model;

@Typescript()
@JsonSerializable()
class UnitTypeEnvelope {
  String id;
  String authorId;
  Races race;
  List<UnitTypeTag> tags;
  int health;
  int armor;
  int speed;
  int range;
  int actions;
  String attack;
  int cost;
  List<AbilityEnvelope> abilities;
  String imageId;
  Map<Lang, String> unitTypeName;
}

class UnitType {
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
  List<String> abilities;
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

