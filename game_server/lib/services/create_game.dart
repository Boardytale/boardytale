part of game_server;

class CreateGameService {
  Future<List<core.LobbyTale>> getGamesToCreate() async {
    String uri =
        makeAddressFromUri(config.editorServer.uris.first) + "inner/lobbyList";
    print(uri);
    http.Response response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    List<core.LobbyTale> lobbies = [];
    if(response.body.isEmpty){
      throw "editor server not responding correctly";
    }
    (jsonDecode(response.body) as List).forEach((lobbyTaleData) {
      core.LobbyTale lobbyTale = core.LobbyTale.fromJson(lobbyTaleData);
      lobbies.add(lobbyTale);
    });
    return lobbies;
  }

  void sendGamesToCreate(ServerPlayer player) async {
    gateway.sendMessage(
        core.ToClientMessage.fromGamesToCreateMessage(
            await createGameService.getGamesToCreate()),
        player);
  }
}
