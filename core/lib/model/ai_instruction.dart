part of model;

@Typescript()
@JsonSerializable()
class AiInstruction {
  UnitCreateOrUpdateAction unitAction;

  static AiInstruction fromJson(Map<String, dynamic> json) {
    return _$AiInstructionFromJson(json);
  }

  Map toJson() {
    return _$AiInstructionToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class AiInstructionSetUnitTarget {
  String unitTaleId;
  AiAction actionOnTarget;
  static AiInstructionSetUnitTarget fromJson(Map<String, dynamic> json) {
    return _$AiInstructionSetUnitTargetFromJson(json);
  }

  Map toJson() {
    return _$AiInstructionSetUnitTargetToJson(this);
  }
}

@Typescript()
enum AiAction {
  @JsonValue('attackAllOnRoad')
  attackAllOnRoad,
  @JsonValue('attackAllNearTarget')
  attackAllNearTarget,
  @JsonValue('attack')
  attack,
  @JsonValue('move')
  move,
}
