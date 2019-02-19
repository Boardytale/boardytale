part of client_model;

class ClientTale extends shared.Tale {
  SettingsService settings;
  Map<String, shared.Player> players = {};

  ClientTale() : super();

  ClientTale.fromClientTaleData(
      shared.ClientTaleData clientTaleData, this.settings) {
    name = clientTaleData.name;
    langName = clientTaleData.langName;
    name = clientTaleData.name;
    world = ClientWorld.fromCreateEnvelope(this, clientTaleData.world, settings);
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
