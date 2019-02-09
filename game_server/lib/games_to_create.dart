part of game_server;

class GamesToCreate {
  static Future<List<shared.LobbyTale>> getGamesToCreate(
      BoardytaleConfiguration config) async {
    String uri = makeAddressFromUri(config.editorServer.uris.first) + "inner/lobbyList";
    print(uri);
    http.Response response = await http.get(uri,headers: {"Content-Type": "application/json"});
    List<shared.LobbyTale> lobbies = [];
    (jsonDecode(response.body) as List).forEach((lobbyTaleData) {
      lobbies.add(shared.LobbyTale.fromJson(lobbyTaleData));
    });
    return lobbies;
  }
}
