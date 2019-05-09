part of model;

@Typescript()
@JsonSerializable()
class ShootAbilityEnvelope {
  /**
   *  steps before shoot
   */
  @TypescriptOptional()
  int steps = 0;

  /**
   *  use 6 expressions separated by space
   *  rules are aligned with range
   *  example: "0 0 1 +1 +2 -1"
   *  every value above 9 will be 9
   */
  @TypescriptOptional()
  String attack;

  Map<String, dynamic> toJson() {
    return _$ShootAbilityEnvelopeToJson(this);
  }

  static ShootAbilityEnvelope fromJson(Map<String, dynamic> json) {
    return _$ShootAbilityEnvelopeFromJson(json);
  }
}

class ShootAbility extends Ability {
  @override
  AbilityName get name => AbilityName.shoot;

  @override
  AbilityReach get reach => AbilityReach.reachArrow;

  /**
   *  use null to use unitOnMove attack
   *  use 6 expressions separated by space
   *  rules are aligned with range
   *  example: "0 0 1 +1 +2 -1"
   *  every value above 9 will be 9
   */
  @TypescriptOptional()
  String attack;

  /**
   *  steps before shoot
   */
  @TypescriptOptional()
  int steps = 0;

  bool validate(Unit unitOnMove, Track track) {
    if (track.fields.length == 1) {
      return false;
    }

    if (unitOnMove.actions == 0) {
      return false;
    }

    if(unitOnMove.far > steps){
      return false;
    }

    if (!track.last.isEnemyOf(unitOnMove.player)) {
      return false;
    }

    if (MapUtils.distance(track.fields.first, track.fields.last) - 1 > unitOnMove.range) {
      return false;
    }

    return true;
  }

  //  List<int> _resolveCurrentAttack(){
  //    return invoker.attack;
  //  }

  fromEnvelope(ShootAbilityEnvelope envelope) {
    if (envelope.attack != null) {
      attack = envelope.attack;
    }
    if (envelope.steps != null) {
      steps = envelope.steps;
    }
  }
}
