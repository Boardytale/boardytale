part of model;

@Typescript()
@JsonSerializable()
class AttackAbility extends Ability {

  /**
   *  use null to use invoker range
   *  use "+1" "-1" to change invoker original
   *  use "4" to set specific range
   *  use "0" for face-to-face units
   *  any range above 7 will be set to 7
    */
  String range;

  /**
   *  use 6 expressions separated by space
   *  rules are aligned with range
   *  example: "0 0 1 +1 +2 -1"
   *  every value above 9 will be 9
   */
  String attack;

  @override
  String get reach => Ability.REACH_HAND;

  Map<String, dynamic> toJson(){
    return _$AttackAbilityToJson(this);
  }

  static AttackAbility fromJson(Map<String, dynamic> json){
    return _$AttackAbilityFromJson(json);
  }

}
