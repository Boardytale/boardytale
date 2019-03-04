part of game_server;

class ServerMoveAbility extends shared.MoveAbility implements ServerAbility {
  @override
  void perform(ServerUnit unit, shared.Track track,
      shared.UnitTrackAction action, ServerTale tale) {
    bool isValid = super.validate(unit, track);

    shared.UnitManipulateAction action = shared.UnitManipulateAction();
    action
      ..unitId = unit.id
      ..actionId = action.actionId;

    if (!isValid) {
      action.isCancel = true;
      if (unit.player != null) {
        gateway.sendMessage(
            shared.ToClientMessage.fromTaleStateUpdate([action]), unit.player);
      } else {
        // TODO: handle reporting errors to AI
      }
      return;
    }
    shared.LiveUnitState state = shared.LiveUnitState()
      ..steps = unit.steps - track.fields.length + 1
      ..far = unit.far + track.fields.length - 1;
    action
      ..isUpdate = true
      ..fieldId = track.last.id
      ..state = state;

    if (steps == 0) {
      state.actions = 0;
    }

    shared.UnitUpdateReport report =
        unit.addUnitUpdateAction(action, track.last);
    tale.onReport.add(report);
    tale.sendNewState(action);
  }
}
