part of game_server;

class NavigationController implements GameController {
  void handle(MessageWithConnection messageWithConnection) async {
    messageWithConnection.player.navigationState = messageWithConnection.message.goToStateMessage.newState;
    restoreState(messageWithConnection.player);
  }

  void restoreState(ServerPlayer player){
    shared.GameNavigationState newState = player.navigationState;
    gateway.sendMessage(shared.ToClientMessage.fromSetNavigationState(newState), player);

    if (newState == shared.GameNavigationState.createGame) {
      sendGamesToCreate(player);
    }
  }

  void sendGamesToCreate(ServerPlayer player) async {
    gateway.sendMessage(shared.ToClientMessage.fromGamesToCreateMessage(
        await createGameService.getGamesToCreate()), player);
  }
}
