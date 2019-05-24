part of game_server;

class ServerAttackAbility extends core.AttackAbility implements ServerAbility {
  @override
  TaleAction perform(
      core.Unit unit, core.Track track, core.UnitTrackAction action, ServerTale tale, Connection unitOnMoveConnection) {
    bool isValid = super.validate(unit, track);
    List<core.UnitCreateOrUpdateAction> unitActions = [];
    TaleAction out = TaleAction()..unitUpdates = unitActions;
    if (!isValid) {
      core.CancelOnFieldAction cancelOnFieldAction = core.CancelOnFieldAction();
      cancelOnFieldAction.fieldId = unit.field.id;
      if (unitOnMoveConnection != null) {
        gateway.sendMessageByConnection(
            core.ToClientMessage.fromCancelOnField([cancelOnFieldAction]), unitOnMoveConnection);
      } else {
        print("AI attack canceled ${json.encode(track.toIds())}");
        // TODO: handle reporting errors to AI
      }
      return out;
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
      ..moveToFieldId = track.fields[track.fields.length - 2].id
      ..unitId = unit.id
      ..actionId = action.actionId
      ..diceNumbers = diceNumbers
      ..explain = core.ActionExplanation.unitAttacking;

    if (steps == 0) {
      action.actions = 0;
    }

    unitActions.add(action);

    int damage = unit.attack[diceNumbers[0]];
    if (diceNumbers.length > 1) {
      damage += diceNumbers[1] + 1;
    }

    // target actions
    // TODO: rethink enhance incoming damage by buff from zero damage
    if (damage > 0) {
      track.fields.last.units.forEach((core.Unit targetUnit) {
        int damageForTargetUnit = targetUnit.resolveIncomingDamage(damage);
        core.UnitCreateOrUpdateAction action = core.UnitCreateOrUpdateAction();
        action
          ..health = targetUnit.actualHealth - damageForTargetUnit
          ..unitId = targetUnit.id
          ..actionId = action.actionId
          ..diceNumbers = diceNumbers
          ..explain = core.ActionExplanation.unitGotDamage
          ..explainFirstValue = damageForTargetUnit.toString();
        unitActions.add(action);
      });
    }
    return out;
  }
}
