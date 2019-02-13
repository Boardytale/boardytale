part of game_server;

class CreateLobbyController implements GameController {
  void handle(MessageWithConnection messageWithConnection) async {
    gateway.sendMessage(
        shared.ToClientMessage.fromSetNavigationState(
            shared.GameNavigationState.inLobby),
        messageWithConnection.player);

    shared.CreateLobby message =
        messageWithConnection.message.createLobbyMessage;

    lobbyService.createLobbyRoom(
        messageWithConnection.player, message.taleName, message.name);
  }
}
