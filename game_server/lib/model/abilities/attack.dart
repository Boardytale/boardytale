part of game_server;

class ServerAttackAbility extends shared.AttackAbility implements ServerAbility {
  @override
  void perform(ServerUnit unit, shared.Track track, shared.UnitTrackAction action, ServerTale tale) {
    bool isValid = super.validate(unit, track);
    if (!isValid) {
      shared.CancelOnFieldAction cancelOnFieldAction = shared.CancelOnFieldAction();
      cancelOnFieldAction.fieldId = unit.field.id;
      if (unit.player != null && unit.player.connection != null) {
        gateway.sendMessage(shared.ToClientMessage.fromCancelOnField([cancelOnFieldAction]), unit.player);
      } else {
        print("AI attack canceled ${json.encode(track.toIds())}");
        // TODO: handle reporting errors to AI
      }
      return;
    }

    List<int> diceNumbers = [math.Random.secure().nextInt(6)];
    if (diceNumbers[0] == 5) {
      diceNumbers.add(math.Random.secure().nextInt(6));
    }

    // invoker action
    shared.UnitCreateOrUpdateAction action = shared.UnitCreateOrUpdateAction();
    action
      ..steps = 0
      ..far = unit.far + track.fields.length - 2
      ..actions = unit.actions - 1
      ..moveToFieldId = track.fields[track.fields.length - 2].id
      ..unitId = unit.id
      ..actionId = action.actionId
      ..diceNumbers = diceNumbers
      ..explain = shared.ActionExplanation.unitAttacked;

    if (steps == 0) {
      action.actions = 0;
    }

    unit.addUnitUpdateAction(action, track.fields[track.fields.length - 2]);
    tale.sendNewState(action);

    int damage = unit.attack[diceNumbers[0]];

    if(diceNumbers.length > 1){
      damage += diceNumbers[1] + 1;
    }

    // target actions
    // TODO: rethink enhance incoming damage by buff from zero damage
    if (damage > 0) {
      track.fields.last.units.forEach((shared.Unit targetUnit) {
        int damageForTargetUnit = targetUnit.resolveIncomingDamage(damage);
        shared.UnitCreateOrUpdateAction action = shared.UnitCreateOrUpdateAction();
        action
          ..health = targetUnit.actualHealth - damageForTargetUnit
          ..unitId = targetUnit.id
          ..actionId = action.actionId
          ..diceNumbers = diceNumbers
          ..explain = shared.ActionExplanation.unitGotDamage
          ..explainFirstValue = damageForTargetUnit.toString();
        targetUnit.addUnitUpdateAction(action, null);
        tale.sendNewState(action);
      });
    }
  }
}
