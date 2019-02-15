part of client_model;

class ClientTale extends shared.Tale {
  SettingsService settings;

  ClientTale() : super();

  ClientTale.fromClientTaleData(
      shared.ClientTaleData clientTaleData, this.settings) {
    name = clientTaleData.name;
    langName = clientTaleData.langName;
    name = clientTaleData.name;
    world = ClientWorld.fromCreateEnvelope(this, clientTaleData.world, settings);
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
