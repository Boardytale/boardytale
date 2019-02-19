part of client_model;

@Injectable()
class ClientTaleService extends shared.Tale {
  SettingsService settings;
  ClientWorldService world;
  Map<String, shared.Player> players = {};

  ClientTaleService(this.settings, this.world) : super();

  void fromClientTaleData(
      shared.ClientTaleData clientTaleData) {
    name = clientTaleData.name;
    langName = clientTaleData.langName;
    name = clientTaleData.name;
    world.fromCreateEnvelope(clientTaleData.world, this);
    clientTaleData.players.forEach((player){
      players[player.id] = player;
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
