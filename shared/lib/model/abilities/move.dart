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

class MoveAbility extends Ability {
  String steps;

  @override
  Map<Targets, List<TargetModificators>> targets;

  @override
  AbilityName get name => AbilityName.move;

  @override
  AbilityReach get reach => AbilityReach.move;

  bool validate(Unit invoker, Track track) {
    if (track.fields.length == 1) {
      return false;
    }
    /**
     *  use null to inherit invoker speed
     *  use "+1" "-1" to modify invoker steps
     *  use "5" to set specific value
     *  every value about 7 is cut
     */
    int currentSteps = invoker.steps;
    if (steps != null) {
      if (steps.contains("+")) {
        currentSteps += int.parse(steps.replaceAll("+", ""));
      } else if (steps.contains("-")) {
        currentSteps -= int.parse(steps.replaceAll("-", ""));
      } else {
        currentSteps = int.parse(steps) - invoker.far;
      }
    }
    if (currentSteps > 7) {
      currentSteps = 7;
    }
    if (currentSteps < 0) {
      currentSteps = 0;
    }

    if (!track.isFreeWay(invoker.player)) {
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
