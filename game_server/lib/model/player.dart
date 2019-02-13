part of game_server;

class ServerPlayer {
  Connection connection;
  shared.GameNavigationState navigationState;
  shared.User user;

  String get email => user.email;

  String get innerToken => user.innerToken;

  set innerToken(String value) {
    user.innerToken = value;
  }

  void setConnection(Connection connection) {
    this.connection = connection;
    connection.player = this;
  }

  shared.LobbyPlayer createLobbyPlayer() {
    return shared.LobbyPlayer()
        ..name = user.name;
  }
}
