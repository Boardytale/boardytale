part of game_server;

class PlayerService {
  int lastPlayerId = 0;
  Map<String, ServerPlayer> playersByInnerToken = {};

  void setPlayer(ServerPlayer player, Connection connection) {
    player.connection = connection;
    connection.player = player;
    playersByInnerToken[player.innerToken] = player;
  }
}
