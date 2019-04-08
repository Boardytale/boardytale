part of game_server;

class ServerMoveAbility extends shared.MoveAbility implements ServerAbility {
  @override
  void perform(ServerUnit unit, shared.Track track, shared.UnitTrackAction action, ServerTale tale) {
    bool isValid = super.validate(unit, track);

    if (!isValid) {
      shared.CancelOnFieldAction cancelOnFieldAction = shared.CancelOnFieldAction();
      cancelOnFieldAction.fieldId = unit.field.id;
      if (unit.player != null && unit.player.connection != null) {
        gateway.sendMessage(shared.ToClientMessage.fromCancelOnField([cancelOnFieldAction]), unit.player);
      } else {
        print("AI move canceled ${json.encode(track.toIds())}");
        // TODO: handle reporting errors to AI
      }
      return;
    }

    shared.UnitCreateOrUpdateAction action = shared.UnitCreateOrUpdateAction();

    action
      ..unitId = unit.id
      ..actionId = action.actionId
      ..steps = unit.steps - track.getMoveCostOfFreeWay()
      ..far = unit.far + track.fields.length - 1
      ..moveToFieldId = track.last.id;

    if (steps == 0) {
      action.actions = 0;
    }

    unit.addUnitUpdateAction(action, track.last);
    tale.sendNewState(action);
  }
}
