part of game_server;

class InitGameService {

  InitGameService(){
    gateway.handlers[shared.OnServerAction.init] = handle;
  }

  void handle(MessageWithConnection messageWithConnection) async {
    String innerToken = messageWithConnection.message.initMessage.innerToken;
    ServerPlayer player;
    if (playerService.playersByInnerToken.containsKey(innerToken)) {
      player = playerService.playersByInnerToken[innerToken];
      player.setConnection(messageWithConnection.connection);
      navigationService.restoreState(player);
      gateway.sendMessage(
          shared.ToClientMessage.fromCurrentUser(player.user), player);
    } else {
      http.Response response = await http.post(
          makeAddressFromUri(config.userServer.uris.first) +
              "inner/getUserByInnerToken",
          headers: {"Content-Type": "application/json"},
          body:
              jsonEncode((InnerTokenWrap()..innerToken = innerToken).asMap()));
      if(response.body.isEmpty){
        // TODO: handle failed login
      }
      shared.User user = shared.User.fromJson(jsonDecode(response.body));
      // TODO: manage username
      user.name = user.email;
      player = ServerPlayer()
        ..id = "${playerService.lastPlayerId++}"
        ..user = user
        ..humanPlayer = (shared.HumanPlayer()..name = user.name)
        ..navigationState = shared.GameNavigationState.findLobby;

      playerService.setPlayer(player, messageWithConnection.connection);

      gateway.sendMessage(shared.ToClientMessage.fromCurrentUser(user), player);

      navigationService.restoreState(player);
    }
  }
}
