part of game_server;

class ServerPlayer extends shared.Player {
  Connection connection;
  shared.GameNavigationState navigationState;
  shared.User user;
  ServerTale tale;
  String color = "#ff0000";

  String get email => user.email;

  String get innerToken => user.innerToken;

  StreamSubscription _lobbyRoomsSubscription;

  void subscribeToOpenedLobbiesChanges() {
    _lobbyRoomsSubscription = lobbyService.openedLobbies.listen((onData) {
      gateway.sendMessage(shared.ToClientMessage.fromLobbyList(onData), this);
    });
  }

  void unsubscribeFromOpenedLobbiesChanges() {
    if (_lobbyRoomsSubscription != null) {
      _lobbyRoomsSubscription.cancel();
    }
  }

  set innerToken(String value) {
    user.innerToken = value;
  }

  void setConnection(Connection connection) {
    this.connection = connection;
    connection.player = this;
  }

  void enterGame(ServerTale tale) {
    this.tale = tale;
//    tale.players[tale.]
    navigationState = shared.GameNavigationState.inGame;
    gateway.sendMessage(shared.ToClientMessage.fromSetNavigationState(navigationState), this);
  }

  shared.Player createGamePlayer() {
    shared.Player gamePlayer = shared.Player()
        ..color = color
        ..taleId = taleId
        ..id = id;
    if(isHumanPlayer){
      return gamePlayer
        ..humanPlayer = (shared.HumanPlayer()..name = user.name);
    }else{
      return gamePlayer
        ..aiGroup = (shared.AiGroup()..langName = aiGroup.langName);
    }

  }

  void fromSharedPlayer(shared.Player input) {
    color = input.color;
    id = input.id;
    taleId = input.taleId;
    team = input.team;
    if (input.isAiPlayer) {
      aiGroup = input.aiGroup;
    } else if(input.isHumanPlayer){
      humanPlayer = input.humanPlayer;
    }else{
      throw "player have to be human or ai";
    }
  }
}
