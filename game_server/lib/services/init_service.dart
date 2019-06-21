part of game_server;

Uuid uuid = Uuid();

class InitGameService {
  static int lastTempUserId = 0;

  InitGameService() {
    gateway.handlers[core.OnServerAction.init] = handle;
  }

  void handle(MessageWithConnection messageWithConnection) async {
    String innerToken = messageWithConnection.message.initInnerToken;
    ServerPlayer player;
    if (innerToken == null) {
      print("inner token not given");
      return;
    }
    if (playerService.playersByInnerToken.containsKey(innerToken)) {
      player = playerService.playersByInnerToken[innerToken];
      if(!player.user.hasHero){
        core.User user = await getUser(innerToken);
        if(user != null){
          player.user.hasHero = user.hasHero;
        }
      }
      player.setConnection(messageWithConnection.connection);
      navigationService.restoreState(player);
      gateway.toClientMessage(core.ToClientMessage.createSetCurrentUser(player.user), player);
    } else {
      core.User user = await getUser(innerToken);
      if (user == null) {
        // user not in database - reset login
        gateway.sendMessageByConnection(core.ToClientMessage.createSetCurrentUser(null), messageWithConnection.connection);
        return;
      }

      if (user.name == null) {
        user.name = user.email;
      }

      player = ServerPlayer()
        ..id = "${playerService.lastPlayerId++}"
        ..user = user
        ..humanPlayer = (core.HumanPlayer()..name = user.name)
        ..navigationState = user.hasHero ? core.GameNavigationState.findLobby : core.GameNavigationState.userPanel;

      playerService.setPlayer(player, messageWithConnection.connection);

      gateway.toClientMessage(core.ToClientMessage.createSetCurrentUser(user), player);

      navigationService.restoreState(player);
    }
  }

  Future<core.User> getUser(String innerToken) async{
    core.ToUserServerInnerMessage responseMessage =
        await gateway.innerMessageToUserServer(core.ToUserServerInnerMessage.createGetUserByInnerToken(innerToken));
    core.User user;
    if (responseMessage.error == null) {
      user = responseMessage.getUser.user;
    } else {
      user = core.User()
        ..email = "${lastTempUserId++}@temp.temp"
        ..innerToken = uuid.v4().toString();
    }
    return user;
  }
}
