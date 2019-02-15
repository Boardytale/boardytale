part of game_server;

class ServerPlayer {
  Connection connection;
  shared.GameNavigationState navigationState;
  shared.User user;
  ServerTale tale;
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

  shared.LobbyPlayer createLobbyPlayer() {
    return shared.LobbyPlayer()..name = user.name;
  }

  void enterGame(ServerTale tale) {
    this.tale = tale;
    navigationState = shared.GameNavigationState.inGame;
    navigationService.restoreState(this);
  }
}
