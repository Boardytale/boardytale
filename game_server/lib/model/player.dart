part of game_server;

class ServerPlayer extends shared.Player{
  String id;
  Connection connection;
  shared.GameNavigationState navigationState;
  shared.User user;
  ServerTale tale;
  int color = Color.Red;
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
    navigationState = shared.GameNavigationState.inGame;
    gateway.sendMessage(
        shared.ToClientMessage.fromSetNavigationState(navigationState), this);
  }

  shared.Player createGamePlayer() {
    return shared.Player()
      ..name = user.name
      ..color = color
      ..id = id
    ;
  }
}
