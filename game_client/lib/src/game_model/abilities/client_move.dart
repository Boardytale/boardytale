part of boardytale.client.abilities;

class ClientMoveAbility implements ClientAbility {
  @override
  void show(shared.Unit invoker, shared.Track track) {
    invoker.move(track);
  }

  @override
  String image;

  String steps;

  @override
  Map<shared.Targets, List<shared.TargetModificators>> targets;

  @override
  // TODO: implement reach
  String get reach => null;

  @override
  bool validate(shared.Unit invoker, shared.Track track) {
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

    if (currentSteps < track.fields.length - 1) {
      return false;
    }
    return track.isFreeWay(invoker.player);
  }

  @override
  shared.Unit invoker;

  @override
  void setInvoker(shared.Unit invoker) {
    // TODO: implement setInvoker
  }

  @override
  shared.AbilityName name;

  fromEnvelope(shared.MoveAbilityEnvelope move) {
    if (move.steps != null) {
      steps = move.steps;
    }
  }
}
