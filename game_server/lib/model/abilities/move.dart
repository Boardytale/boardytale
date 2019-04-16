part of game_server;

class ServerMoveAbility extends core.MoveAbility implements ServerAbility {
  @override
  TaleAction perform(core.Unit unit, core.Track track, core.UnitTrackAction action, ServerTale tale, Connection unitOnMoveConnection) {
    bool isValid = super.validate(unit, track);
    List<core.UnitCreateOrUpdateAction> unitActions = [];
    TaleAction out = TaleAction()..unitUpdates = unitActions;
    if (!isValid) {
      core.CancelOnFieldAction cancelOnFieldAction = core.CancelOnFieldAction();
      cancelOnFieldAction.fieldId = unit.field.id;
      if (unitOnMoveConnection != null) {
        gateway.sendMessageByConnection(core.ToClientMessage.fromCancelOnField([cancelOnFieldAction]), unitOnMoveConnection);
      } else {
        print("AI move canceled ${json.encode(track.toIds())}");
        // TODO: handle reporting errors to AI
      }
      return out;
    }

    core.UnitCreateOrUpdateAction action = core.UnitCreateOrUpdateAction();

    action
      ..unitId = unit.id
      ..actionId = action.actionId
      ..steps = unit.steps - track.getMoveCostOfFreeWay()
      ..far = unit.far + track.fields.length - 1
      ..moveToFieldId = track.last.id;

    if (steps == 0) {
      action.actions = 0;
    }

    unitActions.add(action);
    return out;
  }
}
