part of model;

@JsonSerializable()
@Typescript()
class LiveUnitState {
  String id;
  int far;
  int health;
  List<Buff> buffs = [];
  int actions;

  static LiveUnitState fromJson(Map data) {
    return _$LiveUnitStateFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$LiveUnitStateToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class UnitManipulateAction {
  bool isCreate = false;
  bool isDelete = false;
  bool isUpdate = false;
  String unitTypeName;
  String fieldId;
  String unitId;
  LiveUnitState state;
  String playerId;
  String aiGroupId;


  static UnitManipulateAction fromJson(Map data) {
    return _$UnitManipulateActionFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UnitManipulateActionToJson(this);
  }
}
