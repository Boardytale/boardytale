part of game_server;

class LobbyService {
  int lobbyId = 0;
  Map<String, LobbyRoom> openedLobbies = {};

  Future<LobbyRoom> createLobbyRoom(
      ServerPlayer player, String taleName, String name) async {
    var lobbyPlayer = player.createLobbyPlayer();
    lobbyPlayer.lobbyMaster = true;

    shared.TaleCompiled tale = await getTaleByName(taleName);

    shared.OpenedLobby lobby = shared.OpenedLobby.fromLobbyTale(tale.lobby);
    lobby.players.add(lobbyPlayer);
    lobby.lobbyName = name;
    lobby.id = (lobbyId++).toString();

    LobbyRoom room = LobbyRoom();
    room.connectedPlayers.add(player);
    room.openedLobby.add(lobby);
    return room;
  }

  Future<shared.TaleCompiled> getTaleByName(String name) async {
    String uri =
        makeAddressFromUri(config.editorServer.uris.first) + "inner/taleByName";
    print(jsonEncode(IdWrap.packId(name)));
    http.Response response =
        await http.post(
            uri,
            headers: {"Content-Type": "application/json"},
            body: IdWrap.packId(name));

    print(response.body);
    return shared.TaleCompiled.fromJson(json.decode(response.body));
  }
}
