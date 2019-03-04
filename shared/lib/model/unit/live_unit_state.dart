part of model;

@JsonSerializable()
class LiveUnitState {
  int far;
  int steps;
  int health;
  List<Buff> buffs = [];
  int actions;

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
class UnitManipulateAction {
  bool isCreate = false;
  bool isDelete = false;
  bool isUpdate = false;
  bool isCancel = false;
  String unitTypeName;
  String fieldId;
  String unitId;
  LiveUnitState state;
  String playerId;
  String aiGroupId;

  /// playerId_clientManagedActionId
  String actionId;
  AnimationName animationName;

  static UnitManipulateAction fromJson(Map data) {
    return _$UnitManipulateActionFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitManipulateActionToJson(this);
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
  UnitManipulateAction action;
}

@Typescript()
enum AnimationName {
  @JsonValue('move')
  move,
}
