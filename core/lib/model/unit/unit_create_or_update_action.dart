part of model;

@Typescript()
@JsonSerializable()
class UnitCreateOrUpdateAction {
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String unitId;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String actionId;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  int stepsSpent;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  int steps;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  int health;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  List<Buff> buffs = [];

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  int actions;

  @JsonKey(includeIfNull: false)
  String changeToTypeName;

  @JsonKey(includeIfNull: false)
  String moveToFieldId;

  @JsonKey(includeIfNull: false)
  String transferToPlayerId;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  AnimationName useAnimationName;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  List<int> diceNumbers;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ActionExplanation explain;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String explainFirstValue;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ItemDrops itemDrops;

  static UnitCreateOrUpdateAction fromJson(Map data) {
    return _$UnitCreateOrUpdateActionFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitCreateOrUpdateActionToJson(this);
  }

  void fromUnit(Unit unit) {
    // action not triggered directly by user action
    stepsSpent = unit.far;
    health = unit.actualHealth;
    actions = unit.actions;
    buffs = unit._buffs;
    steps = unit.steps;
  }
}

@JsonSerializable()
class UnitDeleteAction {
  /// playerId_clientManagedActionId
  String actionId;
  String unitId;
  AnimationName animationName;

  static UnitDeleteAction fromJson(Map data) {
    return _$UnitDeleteActionFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitDeleteActionToJson(this);
  }
}

@JsonSerializable()
class CancelOnFieldAction {
  /// playerId_clientManagedActionId
  String actionId;
  String fieldId;
  AnimationName animationName;

  static CancelOnFieldAction fromJson(Map data) {
    return _$CancelOnFieldActionFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$CancelOnFieldActionToJson(this);
  }
}

class UnitUpdateReport {
  Unit unit;
  String newUnitTypeName;
  String newFieldId;
  int deltaFar;
  int deltaSteps;
  int deltaHealth;
  int deltaActions;
  List<String> removedBuffIds;
  List<Buff> buffsAdded;
  UnitCreateOrUpdateAction action;
}

@Typescript()
enum AnimationName {
  @JsonValue('move')
  move,
}

@Typescript()
enum ActionExplanation {
  @JsonValue('unitAttacking')
  unitAttacking,
  @JsonValue('unitGotDamage')
  unitGotDamage,
  @JsonValue('unitHealing')
  unitHealing,
  @JsonValue('unitHealed')
  unitHealed,
}
