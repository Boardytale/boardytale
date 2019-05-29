part of game_server;

abstract class ServerAbility extends core.Ability {
  TaleAction perform(
      core.Unit unit, core.Track track, core.UnitTrackAction action, ServerTale tale, Connection unitOnMoveConnection, {io.WebSocket aiPlayerSocket});

  static TaleAction cancelOnField(core.Unit unitOnMove, Connection unitOnMoveConnection, core.Track track) {
    core.CancelOnFieldAction cancelOnFieldAction = core.CancelOnFieldAction();
    cancelOnFieldAction.fieldId = unitOnMove.field.id;
    if (unitOnMoveConnection != null) {
      gateway.sendMessageByConnection(
          core.ToClientMessage.fromCancelOnField([cancelOnFieldAction]), unitOnMoveConnection);
    } else {
      print("AI attack canceled ${json.encode(track.toIds())}");
      // TODO: handle reporting errors to AI
    }
    return TaleAction()..unitUpdates = [];
  }
}
