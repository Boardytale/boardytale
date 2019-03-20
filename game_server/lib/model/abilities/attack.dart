part of game_server;

class ServerAttackAbility extends shared.AttackAbility implements ServerAbility {
  @override
  void perform(ServerUnit unit, shared.Track track, shared.UnitTrackAction action, ServerTale tale) {
    bool isValid = super.validate(unit, track);
    if (!isValid) {
      shared.CancelOnFieldAction cancelOnFieldAction = shared.CancelOnFieldAction();
      cancelOnFieldAction.fieldId = unit.field.id;
      if (unit.player != null) {
        gateway.sendMessage(shared.ToClientMessage.fromCancelOnField([cancelOnFieldAction]), unit.player);
      } else {
        // TODO: handle reporting errors to AI
      }
      return;
    }

    int diceNumber = math.Random.secure().nextInt(6);

    // invoker action
    shared.UnitCreateOrUpdateAction action = shared.UnitCreateOrUpdateAction();
    shared.LiveUnitState state = shared.LiveUnitState()
      ..steps = 0
      ..far = unit.far + track.fields.length - 2
      ..actions = unit.actions - 1
      ..moveToFieldId = track.fields[track.fields.length - 2].id;

    if (steps == 0) {
      state.actions = 0;
    }

    action
      ..unitId = unit.id
      ..actionId = action.actionId
      ..state = state
      ..diceNumber = diceNumber;

    shared.UnitUpdateReport report = unit.addUnitUpdateAction(action, track.fields[track.fields.length - 2]);
    tale.onReport.add(report);
    tale.sendNewState(action);

    int damage = unit.attack[diceNumber];
    // target actions
    if (damage > 0) {
      track.fields.last.units.forEach((shared.Unit targetUnit) {
        shared.UnitCreateOrUpdateAction action = shared.UnitCreateOrUpdateAction();
        shared.LiveUnitState state = shared.LiveUnitState()..health = targetUnit.actualHealth - damage;

        action
          ..unitId = targetUnit.id
          ..actionId = action.actionId
          ..state = state
          ..diceNumber = diceNumber;
        shared.UnitUpdateReport report = targetUnit.addUnitUpdateAction(action, null);
        tale.onReport.add(report);
        tale.sendNewState(action);
      });
    }
  }
}
