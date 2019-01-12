part of model;

@Typescript()
@JsonSerializable()
class MoveAbility extends Ability {
  @override
  String get reach => Ability.REACH_MOVE;

  /**
   *  use null to inherit invoker speed
   *  use "+1" "-1" to modify invoker steps
   *  use "5" to set specific value
   *  every value about 7 is cut
   */
  String steps;

  Map<String, dynamic> toJson(){
    return _$MoveAbilityToJson(this);
  }

  static MoveAbility fromJson(Map<String, dynamic> json){
    return _$MoveAbilityFromJson(json);
  }
}
