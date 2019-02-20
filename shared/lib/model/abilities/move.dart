part of model;

@Typescript()
@JsonSerializable()
class MoveAbilityEnvelope {
  /**
   *  use null to inherit invoker speed
   *  use "+1" "-1" to modify invoker steps
   *  use "5" to set specific value
   *  every value about 7 is cut
   */
  @TypescriptOptional()
  String steps;

  Map<String, dynamic> toJson() {
    return _$MoveAbilityEnvelopeToJson(this);
  }

  static MoveAbilityEnvelope fromJson(Map<String, dynamic> json) {
    return _$MoveAbilityEnvelopeFromJson(json);
  }
}

@JsonSerializable()
class MoveAction {
  String unitId;
  String toFieldId;
  Map<String, dynamic> toJson() {
    return _$MoveActionToJson(this);
  }

  static MoveAction fromJson(Map<String, dynamic> json) {
    return _$MoveActionFromJson(json);
  }
}

