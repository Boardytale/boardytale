part of game_server;

class NavigationService {
  NavigationService() {
    gateway.handlers[core.OnServerAction.goToState] = handle;
  }

  void handle(MessageWithConnection messageWithConnection) async {
    messageWithConnection.player.navigationState = messageWithConnection.message.goToState.newState;
    restoreState(messageWithConnection.player);
  }

  void restoreState(ServerPlayer player) {
    core.GameNavigationState newState = player.navigationState;

    if(player.room != null){
      newState = core.GameNavigationState.inLobby;
    }

    if (player.tale != null) {
      newState = core.GameNavigationState.inGame;
    }

    if (newState == core.GameNavigationState.createGame) {
      createGameService.sendGamesToCreate(player);
      player.unsubscribeFromOpenedLobbiesChanges();
    }

    if (newState == core.GameNavigationState.inLobby) {
      if (player.room == null) {
        print("bad state player is in lobby, but no room found");
        newState = core.GameNavigationState.findLobby;
        player.navigationState = newState;
      } else {
        player.room.sendUpdateToPlayer(player);
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
