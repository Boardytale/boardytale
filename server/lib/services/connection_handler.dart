library boardytale.server.lobby;

import 'dart:convert';

import 'package:boardytale_server/services/game.dart';
import 'package:utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'connection.dart';

class ConnectionHandler {
  Game currentGame;

  void handleConnection(WebSocketChannel channel){
    Connection connection = new Connection(channel);
    currentGame.addConnection(connection);
  }
}
