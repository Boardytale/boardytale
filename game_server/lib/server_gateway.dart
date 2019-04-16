part of game_server;

class ServerGateway {
  Map<core.OnServerAction, void Function(MessageWithConnection message)> handlers = {};

  void sendMessage(core.ToClientMessage message, ServerPlayer player) {
    player.connection.webSocket.sink.add(json.encode(message.toJson()));
  }

  void sendMessageByConnection(core.ToClientMessage message, Connection connection) {
    connection.webSocket.sink.add(json.encode(message.toJson()));
  }

  void incomingMessage(MessageWithConnection messageWithConnection) async {
    if (messageWithConnection.message.message == core.OnServerAction.init) {
      handlers[core.OnServerAction.init](messageWithConnection);
      return;
    }

    if (messageWithConnection.player != null) {
      if (handlers.containsKey(messageWithConnection.message.message)) {
        handlers[messageWithConnection.message.message](messageWithConnection);
      } else {
        messageWithConnection.connection.webSocket.sink
            .add("missing handler for ${messageWithConnection.message.message}");
      }
    } else {
      //TODO: reconnect message
      messageWithConnection.connection.webSocket.sink.add("player not found - make init first");
    }
  }
}
