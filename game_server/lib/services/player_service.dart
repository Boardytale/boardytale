part of game_server;

class PlayerService {
  Map<String,ServerPlayer> playersByInnerToken = {};

  void setPlayer(ServerPlayer player, Connection connection) {
    player.connection = connection;
    connection.player = player;
    playersByInnerToken[player.innerToken] = player;
  }
}
