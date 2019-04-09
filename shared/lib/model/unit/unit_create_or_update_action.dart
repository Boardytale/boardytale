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
  int far;

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

  /// playerId_clientManagedActionId
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  UnitType newUnitTypeToTale;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  Assets newAssetsToTale;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  Player newPlayerToTale;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  bool isNewPlayerOnMove;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  List<int> diceNumbers;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ActionExplanation explain;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String explainFirstValue;

  static UnitCreateOrUpdateAction fromJson(Map data) {
    return _$UnitCreateOrUpdateActionFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitCreateOrUpdateActionToJson(this);
  }

  void fromUnit(Unit unit) {
    // action not triggered directly by user action
    far = unit.far;
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
  @JsonValue('unitAttacked')
  unitAttacked,
  @JsonValue('unitGotDamage')
  unitGotDamage,
}
