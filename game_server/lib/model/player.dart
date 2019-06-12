part of game_server;

class ServerPlayer extends core.Player {
  Connection connection;
  core.GameNavigationState navigationState;
  core.User user;
  ServerTale tale;
  String color = "#ff0000";
  LobbyRoom room;

  String nextGameHeroId;

  String usedHeroId;

  String get email => user.email;

  String get innerToken => user.innerToken;

  StreamSubscription _lobbyRoomsSubscription;

  ServerPlayer();

  void subscribeToOpenedLobbiesChanges() {
    _lobbyRoomsSubscription = lobbyService.openedLobbyRooms.listen((onData) {
      gateway.sendMessage(core.ToClientMessage.fromLobbyList(lobbyService.getOpenedRoomsClientData()), this);
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
    navigationState = core.GameNavigationState.inGame;
    gateway.sendMessage(core.ToClientMessage.fromSetNavigationState(navigationState), this);
  }

  core.Player createGamePlayer() {
    core.Player gamePlayer = core.Player()
      ..color = color
      ..taleId = taleId
      ..team = team
      ..id = id;
    if (isHumanPlayer) {
      return gamePlayer..humanPlayer = (core.HumanPlayer()..name = user.name);
    } else {
      return gamePlayer..aiGroup = (core.AiGroup()..langName = aiGroup.langName);
    }
  }

  void fromCorePlayer(core.Player input) {
    color = input.color;
    id = input.id;
    taleId = input.taleId;
    team = input.team;
    if (input.isAiPlayer) {
      aiGroup = input.aiGroup;
    } else if (input.isHumanPlayer) {
      humanPlayer = input.humanPlayer;
    } else {
      throw "player have to be human or ai";
    }
  }

  void leaveGame() {
    if(room != null){
      room.ejectPlayer(this);
      if (room.connectedPlayers.isEmpty) {
        room.destroy();
      }
      room = null;
    }
    if(tale != null){
      tale = null;
    }
    navigationState = core.GameNavigationState.findLobby;
    gateway.sendMessage(core.ToClientMessage.fromSetNavigationState(navigationState, destroyCurrentTale: true), this);
  }

  void leaveRoom() {
    unsubscribeFromOpenedLobbiesChanges();
  }
}
