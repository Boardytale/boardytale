part of model;

@Typescript()
@JsonSerializable()
class MoveAbilityEnvelope {
  /**
   *  use null to inherit unitOnMove speed
   *  use "+1" "-1" to modify unitOnMove steps
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

class MoveAbility extends Ability {
  String steps;

  @override
  Map<Targets, List<TargetModificators>> targets;

  @override
  AbilityName get name => AbilityName.move;

  @override
  AbilityReach get reach => AbilityReach.move;

  bool validate(Unit unitOnMove, Track track) {
    if (track.fields.length == 1) {
      return false;
    }
    int currentSteps = resolveCurrentSteps(unitOnMove, steps);

    if (!track.isFreeWay(unitOnMove.player)) {
      return false;
    }
    if (currentSteps < track.getMoveCostOfFreeWay()) {
      return false;
    }
    return true;
  }

  fromEnvelope(MoveAbilityEnvelope move) {
    if (move.steps != null) {
      steps = move.steps;
    }
  }
}
