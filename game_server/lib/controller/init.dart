part of game_server;

class InitGameController implements GameController {
  void handle(MessageWithConnection messageWithConnection) async {
    String innerToken = messageWithConnection.message.initMessage.innerToken;
    ServerPlayer player;
    if (playerService.playersByInnerToken.containsKey(innerToken)) {
      player = playerService.playersByInnerToken[innerToken];
      player.setConnection(messageWithConnection.connection);
      navigationController.restoreState(player);
      gateway.sendMessage(shared.ToClientMessage.fromCurrentUser(player.user), player);
    } else {
      http.Response response = await http.post(
          makeAddressFromUri(config.userServer.uris.first) +
              "inner/getUserByInnerToken",
          headers: {"Content-Type": "application/json"},
          body:
              jsonEncode((InnerTokenWrap()..innerToken = innerToken).asMap()));
      shared.User user = shared.User.fromJson(jsonDecode(response.body));
      player = ServerPlayer()
        ..user = user
        ..navigationState = shared.GameNavigationState.findLobby;

      playerService.setPlayer(player, messageWithConnection.connection);

      gateway.sendMessage(shared.ToClientMessage.fromCurrentUser(user), player);
      gateway.sendMessage(shared.ToClientMessage.fromSetNavigationState(
          player.navigationState), player);
    }
  }
}
