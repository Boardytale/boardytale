part of model;

@Typescript()
@JsonSerializable()
class AttackAbilityEnvelope {
  /**
   *  use null to inherit invoker speed
   *  use "+1" "-1" to modify invoker steps
   *  use "5" to set specific value
   *  every value about 7 is cut
   */
  @TypescriptOptional()
  String steps;

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
  @TypescriptOptional()
  String attack;

  /**
   *  use null to inherit invoker speed
   *  use "+1" "-1" to modify invoker steps
   *  use "5" to set specific value
   *  every value about 7 is cut
   */
  @TypescriptOptional()
  String steps;

  bool validate(Unit invoker, Track track) {
    if (track.fields.length == 1) {
      return false;
    }
    int currentSteps = _resolveCurrentSteps(invoker, steps);

    if(!track.last.isEnemyOf(invoker.player)){
      return false;
    }

    if (!Track.shorten(track, 1).isFreeWay(invoker.player)) {
      return false;
    }

    if (currentSteps <= track.getMoveCostOfFreeWay()) {
      return false;
    }
    return true;
  }

//  List<int> _resolveCurrentAttack(){
//    return invoker.attack;
//  }

  fromEnvelope(AttackAbilityEnvelope envelope) {
    if(envelope.attack != null) {
      attack = envelope.attack;
    }
    if(envelope.steps != null){
      steps = envelope.steps;
    }
  }
}
