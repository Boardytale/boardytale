part of game_server;

class ServerTale {
  LobbyRoom room;
  Map<String, ServerPlayer> get players => room.connectedPlayers;
  shared.ClientTaleData taleData;

  ServerTale(this.room){
    taleData = shared.ClientTaleData.fromCompiledTale(room.compiledTale.tale);
    players.values.forEach((player){
      gateway.sendMessage(shared.ToClientMessage.fromTaleData(taleData), player);
    });
  }

  void handlePlayerAction(MessageWithConnection message){

  }

}

