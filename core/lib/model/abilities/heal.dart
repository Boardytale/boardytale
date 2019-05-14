part of model;

@Typescript()
@JsonSerializable()
class HealAbilityEnvelope {
  /**
   *  use null to inherit unitOnMove speed
   *  use "+1" "-1" to modify unitOnMove steps
   *  use "5" to set specific value
   *  every value about 7 is cut
   */
  @TypescriptOptional()
  int steps;

  /**
   *  use 6 expressions separated by space
   *  rules are aligned with range
   *  example: "0 0 1 +1 +2 -1"
   *  every value above 9 will be 9
   */
  @TypescriptOptional()
  String effect;

  /**
   *  use null to inherit unitOnMove range
   *  use "+1" "-1" to modify unitOnMove range
   *  use "5" to set specific value
   *  every value about 7 is cut
   */
  String range;

  Map<String, dynamic> toJson() {
    return _$HealAbilityEnvelopeToJson(this);
  }

  static HealAbilityEnvelope fromJson(Map<String, dynamic> json) {
    return _$HealAbilityEnvelopeFromJson(json);
  }
}

class HealAbility extends Ability {
  @override
  AbilityName get name => AbilityName.heal;

  @override
  AbilityReach get reach => AbilityReach.conjuration;

  /**
   *  use null to use unitOnMove attack
   *  use 6 expressions separated by space
   *  rules are aligned with range
   *  example: "0 0 1 +1 +2 -1"
   *  every value above 9 will be 9
   */
  @TypescriptOptional()
  String effect;

  /**
   *  use null to inherit unitOnMove speed
   *  use "+1" "-1" to modify unitOnMove steps
   *  use "5" to set specific value
   *  every value about 7 is cut
   */
  @TypescriptOptional()
  int steps = 0;

  String range;

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

    Unit aliveHarmedAlly = track.last.getFirstHarmedAliveAllyOnTheField(unitOnMove.player);
    if (aliveHarmedAlly == null) {
      return false;
    }

    int resolvedRange = super.resolveStandardModificator(unitOnMove.range, range);

    if (MapUtils.distance(track.fields.first, track.fields.last) > resolvedRange) {
      return false;
    }

    return true;
  }

  fromEnvelope(HealAbilityEnvelope envelope) {
    if (envelope.effect != null) {
      effect = envelope.effect;
    }
    if (envelope.steps != null) {
      steps = envelope.steps;
    }
    if (envelope.range != null) {
      range = envelope.range;
    }
  }
}
