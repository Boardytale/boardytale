part of model;

@JsonSerializable()
class LiveUnitState {
  String id;
  int far;
  int health;
  List<Buff> buffs = [];
  int actions;
  String newFieldId;

  static LiveUnitState fromJson(Map data) {
    return _$LiveUnitStateFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$LiveUnitStateToJson(this);
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

  static UnitManipulateAction fromJson(Map data) {
    return _$UnitManipulateActionFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitManipulateActionToJson(this);
  }
}
