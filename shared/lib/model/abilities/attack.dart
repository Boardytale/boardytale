part of model;

@Typescript()
@JsonSerializable()
class AttackAbilityEnvelope {

  /**
   *  use null to use invoker range
   *  use "+1" "-1" to change invoker original
   *  use "4" to set specific range
   *  use "0" for face-to-face units
   *  any range above 7 will be set to 7
    */
  @TypescriptOptional()
  String range;

  /**
   *  use 6 expressions separated by space
   *  rules are aligned with range
   *  example: "0 0 1 +1 +2 -1"
   *  every value above 9 will be 9
   */
  @TypescriptOptional()
  String attack;

  Map<String, dynamic> toJson(){
    return _$AttackAbilityEnvelopeToJson(this);
  }

  static AttackAbilityEnvelope fromJson(Map<String, dynamic> json){
    return _$AttackAbilityEnvelopeFromJson(json);
  }

}
