part of game_server;

class ServerMoveAbility extends core.MoveAbility implements ServerAbility {
  @override
  TaleAction perform(
      core.Unit unit, core.Track track, core.UnitTrackAction action, ServerTale tale, Connection unitOnMoveConnection, {io.WebSocket aiPlayerSocket}) {
    bool isValid = super.validate(unit, track);
    List<core.UnitCreateOrUpdateAction> unitActions = [];
    TaleAction out = TaleAction()..unitUpdates = unitActions;
    if (!isValid) {
      return ServerAbility.cancelOnField(unit, unitOnMoveConnection, track);
    }

    core.UnitCreateOrUpdateAction action = core.UnitCreateOrUpdateAction();

    action
      ..unitId = unit.id
      ..actionId = action.actionId
      ..steps = unit.steps - track.getMoveCostOfFreeWay()
      ..stepsSpent = unit.far + track.fields.length - 1
      ..moveToFieldId = track.last.id;

    if (steps == 0) {
      action.actions = 0;
    }

    unitActions.add(action);
    return out;
  }
}
