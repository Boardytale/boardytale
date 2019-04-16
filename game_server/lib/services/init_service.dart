part of game_server;

class InitGameService {
  InitGameService() {
    gateway.handlers[core.OnServerAction.init] = handle;
  }

  void handle(MessageWithConnection messageWithConnection) async {
    String innerToken = messageWithConnection.message.initMessage.innerToken;
    ServerPlayer player;
    if (playerService.playersByInnerToken.containsKey(innerToken)) {
      player = playerService.playersByInnerToken[innerToken];
      player.setConnection(messageWithConnection.connection);
      navigationService.restoreState(player);
      gateway.sendMessage(core.ToClientMessage.fromCurrentUser(player.user), player);
    } else {
      var url = "http://localhost:${config.userServer.innerPort}/";
      http.Response response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(core.ToUserServerMessage.fromInnerToken(innerToken)));

      core.ToUserServerMessage responseMessage = core.ToUserServerMessage.fromJson(json.decode(response.body));

      core.User user = responseMessage.getUser.user;

      if (user == null) {
        // user not in database - reset login
        gateway.sendMessageByConnection(core.ToClientMessage.fromCurrentUser(null), messageWithConnection.connection);
        return;
      }

      if (response.body.isEmpty) {
        // TODO: handle failed login
      }
      // TODO: manage username
      user.name = user.email;
      player = ServerPlayer()
        ..id = "${playerService.lastPlayerId++}"
        ..user = user
        ..humanPlayer = (core.HumanPlayer()..name = user.name)
        ..navigationState = core.GameNavigationState.findLobby;

      playerService.setPlayer(player, messageWithConnection.connection);

      gateway.sendMessage(core.ToClientMessage.fromCurrentUser(user), player);

      navigationService.restoreState(player);
    }
  }
}
