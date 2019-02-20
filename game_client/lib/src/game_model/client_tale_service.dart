part of client_model;

@Injectable()
class ClientTaleService extends shared.Tale {
  SettingsService settings;
  ClientWorldService world;
  AppService appService;
  Map<String, ClientPlayer> get players => appService.players;
  Map<String, shared.UnitType> unitTypes = {};

  ClientTaleService(this.settings, this.world, this.appService) : super();

  void fromClientTaleData(
      shared.ClientTaleData clientTaleData) {
    name = clientTaleData.name;
    langName = clientTaleData.langName;
    name = clientTaleData.name;
    world.fromCreateEnvelope(clientTaleData.world, this);
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
