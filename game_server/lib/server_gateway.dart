part of game_server;

class ServerGateway {
  WebSocketChannel webSocket;

  void sendMessage(shared.ToClientMessage message){
    webSocket.sink.add(json.encode(message.toJson()));
  }

  void incomingMessage(shared.ToGameServerMessage message){
    if (message.message == shared.OnServerAction.goToState) {
      sendMessage(shared.ToClientMessage.fromSetNavigationState(
          message.goToState.newState));
    } else if (message.message == shared.OnServerAction.init) {
      sendMessage(shared.ToClientMessage.fromSetNavigationState(
          shared.GameNavigationState.findLobby));
    } else {
      webSocket.sink.add("sent ${jsonEncode(message.toJson())} not recognized");
    }
  }
}
