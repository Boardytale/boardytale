part of game_server;

class GameService {
  Map<String, ServerTale> tales = {};

  GameService() {
    gateway.handlers[shared.OnServerAction.enterGame] = handleEnterGame;
    gateway.handlers[shared.OnServerAction.unitTrackAction] =
        handleUnitTrackAction;
    gateway.handlers[shared.OnServerAction.controlsAction] =
        handleControlsAction;
  }

  void handleEnterGame(MessageWithConnection message) {
    String lobbyId = message.message.enterGameMessage.lobbyId;
    LobbyRoom room = lobbyService.getLobbyRoomById(lobbyId);

    ServerTale tale = ServerTale(room);

    tales[room.id] = tale;

    room.connectedPlayers.values.forEach((player) {
      player.enterGame(tale);
    });
  }

  void handleUnitTrackAction(MessageWithConnection message) {
    message.player.tale.handleUnitTrack(message);
  }

  void handleControlsAction(MessageWithConnection message) {
    if(message.message.controlsActionMessage.actionName == shared.ControlsActionName.andOfTurn){
      message.player.tale.endOfTurn(message);
    }
  }

}
