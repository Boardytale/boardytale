part of game_server;

class ServerHealAbility extends core.HealAbility implements ServerAbility {
  @override
  TaleAction perform(
      core.Unit unit, core.Track track, core.UnitTrackAction action, ServerTale tale, Connection unitOnMoveConnection) {
    bool isValid = super.validate(unit, track);
    List<core.UnitCreateOrUpdateAction> unitActions = [];
    TaleAction out = TaleAction()..unitUpdates = unitActions;
    if (!isValid) {
      return ServerAbility.cancelOnField(unit, unitOnMoveConnection, track);
    }

    List<int> diceNumbers = [math.Random.secure().nextInt(6)];
    if (diceNumbers[0] == 5) {
      diceNumbers.add(math.Random.secure().nextInt(6));
    }

    // invoker action
    core.UnitCreateOrUpdateAction action = core.UnitCreateOrUpdateAction();
    action
      ..steps = 0
      ..stepsSpent = unit.far + track.fields.length - 2
      ..actions = unit.actions - 1
      ..unitId = unit.id
      ..actionId = action.actionId
      ..diceNumbers = diceNumbers
      ..explain = core.ActionExplanation.unitHealing;

    if (steps == 0) {
      action.actions = 0;
    }

    unitActions.add(action);

    List<int> effect = resolveSixNumberEffect(unit.attack, super.effect);

    int healPower = effect[diceNumbers[0]];
    if (diceNumbers.length > 1) {
      healPower += diceNumbers[1] + 1;
    }

    // target actions
    if (healPower > 0) {
      core.Unit targetUnit = track.last.getFirstHarmedAliveAllyOnTheField(unit.player);
      if (targetUnit != null) {
        int newHealth = targetUnit.actualHealth + healPower;
        if (newHealth > targetUnit.type.health) {
          newHealth = targetUnit.type.health;
        }
        core.UnitCreateOrUpdateAction action = core.UnitCreateOrUpdateAction();
        action
          ..health = newHealth
          ..unitId = targetUnit.id
          ..actionId = action.actionId
          ..diceNumbers = diceNumbers
          ..explain = core.ActionExplanation.unitHealed
          ..explainFirstValue = healPower.toString();
        unitActions.add(action);
      } else {
        return ServerAbility.cancelOnField(unit, unitOnMoveConnection, track);
      }
    }
    return out;
  }
}
