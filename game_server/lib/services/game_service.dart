part of game_server;

class GameService {
  static const int secondsToEnterRunningGame = 90;
  static const int minutesToEndGame = 120;

  Map<String, ServerTale> tales = {};

  GameService() {
    gateway.handlers[core.OnServerAction.enterGame] = handleEnterGame;
    gateway.handlers[core.OnServerAction.unitTrackAction] = handleUnitTrackAction;
    gateway.handlers[core.OnServerAction.controlsAction] = handleControlsAction;
    gateway.handlers[core.OnServerAction.leaveGame] = handleLeaveGame;
  }

  void handleEnterGame(MessageWithConnection message) {
    String lobbyId = message.message.enterGameLobbyId;
    LobbyRoom room = lobbyService.getLobbyRoomById(lobbyId);

    if (room == null) {
      print("entering game on null room for player ${message.player.email}  lobbyId: ${lobbyId}");
      return;
    }

    if (room.connectedPlayers.length >= 4) {
      print("too much connected players");
      // TODO: send info to client
      return;
    }

    if (room.gameRunning) {
      room.tale.newPlayerEntersTale(message.player);
    } else {
      room.gameRunning = true;
      ServerTale tale = ServerTale(room);
      tales[room.id] = tale;
      room.tale = tale;
      room.connectedPlayers.values.forEach((player) {
        player.enterGame(tale);
      });
      Future.delayed(Duration(seconds: GameService.secondsToEnterRunningGame)).then((_) {
        room.closedForNewPlayers = true;
        lobbyService.removeLobbyRoom(room);
      });
      Future.delayed(Duration(minutes: GameService.minutesToEndGame)).then((_) {
        room.connectedPlayers.values.toList().forEach((player) {
          if (player.tale.room == room) {
            player.leaveGame();
          }
        });
      });
    }
  }

  void handleUnitTrackAction(MessageWithConnection message) {
    message.player.tale.handleUnitTrackAction(message.message.unitTrackAction);
  }

  void handleLeaveGame(MessageWithConnection message) {
    message.player.leaveGame();
  }

  void handleControlsAction(MessageWithConnection message) {
    if (message.message.controlsAction.actionName == core.ControlsActionName.endOfTurn) {
      message.player.tale.endOfTurn();
    }
  }
}
