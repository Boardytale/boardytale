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

  Future<core.ToUserServerMessage> innerMessageToUserServer(core.ToUserServerMessage message) {
    return toUserServerMessage(message, true);
  }

  Future<core.ToUserServerMessage> toUserServerMessage(core.ToUserServerMessage message, [bool inner = false]) async {
    var url = "http://localhost:${config.userServer.uris.first.port}/userApi/toUserMessage";
    if (inner) {
      url = "http://localhost:${config.userServer.innerPort}/";
    }
    http.Response response;
    try {
      response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(message));
    } catch (e) {
      return core.ToUserServerMessage()..error = "user server not working properly";
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      return core.ToUserServerMessage.fromJson(responseBody);
    } else {
      return core.ToUserServerMessage()..error = response.body;
    }
  }
}
