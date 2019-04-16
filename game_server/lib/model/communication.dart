part of game_server;

class MessageWithConnection {
  core.ToGameServerMessage message;
  Connection connection;
  ServerPlayer get player => connection.player;
}

class Connection {
  int id;
  WebSocketChannel webSocket;
  ServerPlayer player;
}
