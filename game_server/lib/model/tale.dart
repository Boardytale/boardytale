part of game_server;

class ServerTale {
  static const colors = const[Color.Red, Color.Blue, Color.Green, Color.Yellow];
  LobbyRoom room;
  Map<String, ServerPlayer> get players => room.connectedPlayers;
  shared.ClientTaleData taleData;
  shared.Tale sharedTale;
  Map<String, shared.UnitType> unitTypes = {};

  ServerTale(this.room){
    int index = 0;
    sharedTale = shared.Tale()..fromCompiledTale(room.compiledTale.tale);
    taleData = shared.ClientTaleData.fromCompiledTale(room.compiledTale.tale);
    players.values.forEach((player){
      player.color = ServerTale.colors[index++];
    });

    List<shared.Player> gamePlayers = [];
    players.values.forEach((player){
      gamePlayers.add(player.createGamePlayer());
    });

    taleData.players = gamePlayers;

    players.values.forEach((player){
      gateway.sendMessage(shared.ToClientMessage.fromTaleData(taleData), player);
    });
  }

  void sendInitTaleDataToPlayer(ServerPlayer player){
      gateway.sendMessage(shared.ToClientMessage.fromTaleData(taleData), player);
  }

  void handlePlayerAction(MessageWithConnection message){

  }

  void sendInitialUnits(){
    room.compiledTale.tale.assets.unitTypes.forEach((String name, shared.UnitTypeCompiled unitType){
      unitTypes[name] = shared.UnitType()..fromCompiledUnitType(unitType);
    });


    // TODO: implement line of sight here
    room.compiledTale.tale.units.forEach((fieldId, unitName){
      shared.UnitTypeCompiled unitType = room.compiledTale.tale.assets.unitTypes[unitName];

    });

  }

}

