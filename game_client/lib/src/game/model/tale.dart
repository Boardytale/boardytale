part of client_model;

class ClientTale extends shared.Tale {
  ClientTale() : super();

  static ClientTale fromClientTaleData(shared.ClientTaleData clientTaleData) {
    ClientTale out = ClientTale();

    return out;
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
