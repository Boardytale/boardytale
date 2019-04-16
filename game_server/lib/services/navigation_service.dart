part of game_server;

class NavigationService {
  NavigationService() {
    gateway.handlers[core.OnServerAction.goToState] = handle;
  }

  void handle(MessageWithConnection messageWithConnection) async {
    messageWithConnection.player.navigationState =
        messageWithConnection.message.goToStateMessage.newState;
    restoreState(messageWithConnection.player);
  }

  void restoreState(ServerPlayer player) {
    core.GameNavigationState newState = player.navigationState;
    gateway.sendMessage(
        core.ToClientMessage.fromSetNavigationState(newState), player);

    if (newState == core.GameNavigationState.findLobby) {
      player.subscribeToOpenedLobbiesChanges();
    }

    if (newState == core.GameNavigationState.createGame) {
      createGameService.sendGamesToCreate(player);
      player.unsubscribeFromOpenedLobbiesChanges();
    }

    if (newState == core.GameNavigationState.inLobby) {
      LobbyRoom currentPlayerRoom = lobbyService.getLobbyRoomByPlayer(player);
      currentPlayerRoom.sendUpdateToPlayer(player);
      player.unsubscribeFromOpenedLobbiesChanges();
    }

    if(newState == core.GameNavigationState.inGame){
      player.tale.sendTaleDataToPlayer(player);
    }
  }
}
