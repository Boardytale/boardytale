part of game_server;

class ServerMoveAbility extends shared.MoveAbility implements ServerAbility {
  @override
  void perform(ServerUnit unit, shared.Track track,
      shared.UnitTrackAction action, ServerTale tale) {
    bool isValid = super.validate(unit, track);

    if (!isValid) {
      shared.CancelOnFieldAction cancelOnFieldAction =
          shared.CancelOnFieldAction();
      cancelOnFieldAction.fieldId = unit.field.id;
      if (unit.player != null) {
        gateway.sendMessage(
            shared.ToClientMessage.fromTaleStateUpdate([cancelOnFieldAction]),
            unit.player);
      } else {
        // TODO: handle reporting errors to AI
      }
      return;
    }

    shared.UnitCreateOrUpdateAction action = shared.UnitCreateOrUpdateAction();

    shared.LiveUnitState state = shared.LiveUnitState()
      ..steps = unit.steps - track.fields.length + 1
      ..far = unit.far + track.fields.length - 1
      ..moveToFieldId = track.last.id;

    if (steps == 0) {
      state.actions = 0;
    }

    action
      ..unitId = unit.id
      ..actionId = action.actionId
      ..state = state;

    shared.UnitUpdateReport report =
        unit.addUnitUpdateAction(action, track.last);
    tale.onReport.add(report);
    tale.sendNewState(action);
  }
}
