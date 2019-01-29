part of game_server;

class ServerGateway {
  WebSocketChannel webSocket;
  ServerPlayer player;
  LobbyRoom lobbyRoom;
  final BoardytaleConfiguration config;

  ServerGateway(this.config);

  void sendMessage(shared.ToClientMessage message) {
    webSocket.sink.add(json.encode(message.toJson()));
  }

  void incomingMessage(shared.ToGameServerMessage message) async {
    if (message.message == shared.OnServerAction.goToState) {
      shared.GameNavigationState newState = message.goToStateMessage.newState;
      if (newState == shared.GameNavigationState.createGame) {
        sendGamesToCreate();
      }
//      shared.ToClientMessage.fromSetNavigationState(
//          message.goToState.newState).;
//      sendMessage();
    } else if (message.message == shared.OnServerAction.init) {
      handleInit(message);
    } else {
      webSocket.sink.add("sent ${jsonEncode(message.toJson())} not recognized");
    }
  }

  void sendGamesToCreate() async {
    sendMessage(shared.ToClientMessage.fromGamesToCreateMessage(
        await GamesToCreate.getGamesToCreate(config)));
  }

  void handleInit(shared.ToGameServerMessage message) async {
    http.Response response = await http.post(
        makeAddressFromUri(config.userServer.uris.first) +
            "inner/getUserByInnerToken",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode((InnerTokenWrap()
              ..innerToken = message.initMessage.innerToken)
            .asMap()));
    player = ServerPlayer()
      ..email = shared.User.fromJson(jsonDecode(response.body)).email;
    print(player.email);
    sendMessage(shared.ToClientMessage.fromSetNavigationState(
        shared.GameNavigationState.findLobby));
    lobbyRoom = new LobbyRoom(this);
  }
}
