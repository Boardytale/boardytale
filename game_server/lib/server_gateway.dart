part of game_server;

class ServerGateway {
  void sendMessage(shared.ToClientMessage message, ServerPlayer player) {
    player.connection.webSocket.sink.add(json.encode(message.toJson()));
  }

  // TODO: refactor to handlers
  void incomingMessage(MessageWithConnection messageWithConnection) async {
    if (messageWithConnection.message.message == shared.OnServerAction.init) {
      initGameController.handle(messageWithConnection);
      return;
    }

    if (messageWithConnection.player != null) {
      if (messageWithConnection.message.message ==
          shared.OnServerAction.goToState) {
        navigationController.handle(messageWithConnection);
      } else if(messageWithConnection.message.message ==
          shared.OnServerAction.createLobby){
         createLobbyController.handle(messageWithConnection);
      } else {
        messageWithConnection.connection.webSocket.sink.add(
            "sent ${jsonEncode(messageWithConnection.message.toJson())} not recognized");
      }
    } else {
      //TODO: reconnect message
      messageWithConnection.connection.webSocket.sink.add("player not found - make init first");
    }
  }
}
