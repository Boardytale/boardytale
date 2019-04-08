part of game_server;

class GameService {
  Map<String, ServerTale> tales = {};

  GameService() {
    gateway.handlers[shared.OnServerAction.enterGame] = handleEnterGame;
    gateway.handlers[shared.OnServerAction.unitTrackAction] = handleUnitTrackAction;
    gateway.handlers[shared.OnServerAction.controlsAction] = handleControlsAction;
  }

  void handleEnterGame(MessageWithConnection message) {
    String lobbyId = message.message.enterGameMessage.lobbyId;
    LobbyRoom room = lobbyService.getLobbyRoomById(lobbyId);

    if(room.connectedPlayers.length >= 4){
      print("too much connected players");
      // TODO: send info to client
      return;
    }

    if (room.gameRunning) {
      message.player.enterGame(room.tale);
      room.tale.addHumanPlayer(message.player);
      room.tale.sendInitTaleDataToPlayer(message.player);
      HeroesHelper.getHeroes([message.player], room.connectedPlayers.values, room.tale);
    } else {
      room.gameRunning = true;
      ServerTale tale = ServerTale(room);
      tales[room.id] = tale;
      room.tale = tale;
      room.connectedPlayers.values.forEach((player) {
        player.enterGame(tale);
      });
    }
  }

  void handleUnitTrackAction(MessageWithConnection message) {
    message.player.tale.handleUnitTrackAction(message.message.unitTrackActionMessage);
  }

  void handleControlsAction(MessageWithConnection message) {
    if (message.message.controlsActionMessage.actionName == shared.ControlsActionName.endOfTurn) {
      message.player.tale.endOfTurn(message);
    }
  }
}
