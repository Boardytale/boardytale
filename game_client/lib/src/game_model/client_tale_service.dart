part of client_model;

@Injectable()
class ClientTaleService extends shared.Tale {
  SettingsService settings;
  ClientWorldService clientWorldService;
  AppService appService;
  Map<String, ClientPlayer> get aiPlayers => appService.players;
  Map<String, shared.UnitType> unitTypes = {};
  GatewayService gatewayService;
  GameService gameService;

  ClientTaleService(this.gatewayService,this.settings, this.clientWorldService, this.appService) : super(){
    handleTaleData(gameService.clientTaleData);
  }
  void handleTaleData( shared.ClientTaleData clientTaleData) {
    fromClientTaleData(clientTaleData);
    aiPlayers.forEach((String id, shared.Player player) {
      ClientPlayer newPlayer = ClientPlayer()..fromSharedPlayer(player);
      appService.players[id] = newPlayer;
      if (newPlayer.id == clientTaleData.playerIdOnThisClientMachine) {
        appService.currentPlayer = newPlayer;
      }
    });
    gameService.setPlayersOnMoveByIds(clientTaleData.playerOnMoveIds);
    gameService.onWorldLoaded.add(clientWorldService);
  }

  void fromClientTaleData(
      shared.ClientTaleData clientTaleData) {
    name = clientTaleData.name;
    langName = clientTaleData.langName;
    name = clientTaleData.name;
    clientWorldService.fromCreateEnvelope(clientTaleData.world, this);
    clientTaleData.players.forEach((player){
      if(appService.players.containsKey(player.id)){
        appService.players[player.id].fromSharedPlayer(player);
      }else{
        appService.players[player.id] = ClientPlayer()..fromSharedPlayer(player);
      }
    });
    clientTaleData.assets.unitTypes
        .forEach((String name, shared.UnitTypeCompiled unitType) {
      unitTypes[name] = shared.UnitType()..fromCompiledUnitType(unitType);
    });
  }

//  @override
//  void update(Map<String, dynamic> state) {
////    super.update(state);
//    List<Map<String, dynamic>> playerMapList = state["players"];
//    for (Map<String, dynamic> playerMap in playerMapList) {
////      Player player = players[playerMap["id"]];
////      if (player == null) continue;
//    }
//  }
}
