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

  Map<String, dynamic> toJson() {
    return _$AttackAbilityEnvelopeToJson(this);
  }

  static AttackAbilityEnvelope fromJson(Map<String, dynamic> json) {
    return _$AttackAbilityEnvelopeFromJson(json);
  }
}

class AttackAbility extends Ability {
  @override
  AbilityName get name => AbilityName.attack;

  @override
  AbilityReach get reach => AbilityReach.hand;


  /**
   *  use null to use invoker attack
   *  use 6 expressions separated by space
   *  rules are aligned with range
   *  example: "0 0 1 +1 +2 -1"
   *  every value above 9 will be 9
   */
  String attack;

  /**
   *  use null to use invoker range
   *  use "+1" "-1" to change invoker original
   *  use "4" to set specific range
   *  use "0" for face-to-face units
   *  any range above 7 will be set to 7
   */
  String range;

  bool validate(Unit invoker, Track track) {
//    int currentSteps = invoker.steps;
//    if (steps != null) {
//      if (steps.contains("+")) {
//        currentSteps += int.parse(steps.replaceAll("+", ""));
//      } else if (steps.contains("-")) {
//        currentSteps -= int.parse(steps.replaceAll("-", ""));
//      } else {
//        currentSteps = int.parse(steps) - invoker.far;
//      }
//    }
//    if (currentSteps > 7) {
//      currentSteps = 7;
//    }
//    if (currentSteps < 0) {
//      currentSteps = 0;
//    }
//
//    if (currentSteps < track.fields.length - 1) {
//      return false;
//    }
    return track.isFreeWay(invoker.player);
  }

  fromEnvelope(AttackAbilityEnvelope envelope) {
    if(envelope.attack != null) {
      attack = envelope.attack;
    }
    if(envelope.range != null){
      range = envelope.range;
    }
  }
}
