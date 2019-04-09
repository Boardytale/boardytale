part of game_server;

class NavigationService {
  NavigationService() {
    gateway.handlers[shared.OnServerAction.goToState] = handle;
  }

  void handle(MessageWithConnection messageWithConnection) async {
    messageWithConnection.player.navigationState =
        messageWithConnection.message.goToStateMessage.newState;
    restoreState(messageWithConnection.player);
  }

  void restoreState(ServerPlayer player) {
    shared.GameNavigationState newState = player.navigationState;
    gateway.sendMessage(
        shared.ToClientMessage.fromSetNavigationState(newState), player);

    if (newState == shared.GameNavigationState.findLobby) {
      player.subscribeToOpenedLobbiesChanges();
    }

    if (newState == shared.GameNavigationState.createGame) {
      createGameService.sendGamesToCreate(player);
      player.unsubscribeFromOpenedLobbiesChanges();
    }

    if (newState == shared.GameNavigationState.inLobby) {
      LobbyRoom currentPlayerRoom = lobbyService.getLobbyRoomByPlayer(player);
      currentPlayerRoom.sendUpdateToPlayer(player);
      player.unsubscribeFromOpenedLobbiesChanges();
    }

    if(newState == shared.GameNavigationState.inGame){
      player.tale.sendTaleDataToPlayer(player);
    }
  }
}
