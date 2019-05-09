part of game_server;

class NavigationService {
  NavigationService() {
    gateway.handlers[core.OnServerAction.goToState] = handle;
  }

  void handle(MessageWithConnection messageWithConnection) async {
    messageWithConnection.player.navigationState = messageWithConnection.message.goToStateMessage.newState;
    restoreState(messageWithConnection.player);
  }

  void restoreState(ServerPlayer player) {
    core.GameNavigationState newState = player.navigationState;

    if (newState == core.GameNavigationState.createGame) {
      createGameService.sendGamesToCreate(player);
      player.unsubscribeFromOpenedLobbiesChanges();
    }

    if (newState == core.GameNavigationState.inLobby) {
      LobbyRoom currentPlayerRoom = lobbyService.getLobbyRoomByPlayer(player);
      if (currentPlayerRoom == null) {
        print("bad state player is in lobby, but no room found");
        newState = core.GameNavigationState.findLobby;
        player.navigationState = newState;
      } else {
        currentPlayerRoom.sendUpdateToPlayer(player);
        player.unsubscribeFromOpenedLobbiesChanges();
      }
    }

    if (newState == core.GameNavigationState.findLobby) {
      player.subscribeToOpenedLobbiesChanges();
    }

    if (newState == core.GameNavigationState.inGame) {
      player.tale.sendTaleDataToPlayer(player);
    }
    gateway.sendMessage(core.ToClientMessage.fromSetNavigationState(newState), player);
  }
}
