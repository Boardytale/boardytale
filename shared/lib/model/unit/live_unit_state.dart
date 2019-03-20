part of model;

@JsonSerializable()
class LiveUnitState {
  @JsonKey(includeIfNull: false)
  int far;

  @JsonKey(includeIfNull: false)
  int steps;

  @JsonKey(includeIfNull: false)
  int health;

  @JsonKey(includeIfNull: false)
  List<Buff> buffs = [];

  @JsonKey(includeIfNull: false)
  int actions;

  @JsonKey(includeIfNull: false)
  String changeToTypeName;

  @JsonKey(includeIfNull: false)
  String moveToFieldId;

  @JsonKey(includeIfNull: false)
  String transferToPlayerId;

  @JsonKey(includeIfNull: false)
  AnimationName useAnimationName;

  static LiveUnitState fromJson(Map data) {
    return _$LiveUnitStateFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$LiveUnitStateToJson(this);
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
class UnitCreateOrUpdateAction {
  /// playerId_clientManagedActionId
  String actionId;
  String unitId;
  LiveUnitState state;
  @JsonKey(includeIfNull: false)
  UnitTypeCompiled newUnitTypeToTale;
  @JsonKey(includeIfNull: false)
  Player newPlayerToTale;
  @JsonKey(includeIfNull: false)
  bool isNewPlayerOnMove;
  @JsonKey(includeIfNull: false)
  int diceNumber;

  static UnitCreateOrUpdateAction fromJson(Map data) {
    return _$UnitCreateOrUpdateActionFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitCreateOrUpdateActionToJson(this);
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
