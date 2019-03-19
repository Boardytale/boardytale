part of game_server;

class LobbyService {
  int lobbyId = 0;
  BehaviorSubject<List<LobbyRoom>> openedLobbyRooms =
      BehaviorSubject<List<LobbyRoom>>(seedValue: []);

  BehaviorSubject<List<shared.OpenedLobby>> openedLobbies =
      BehaviorSubject<List<shared.OpenedLobby>>(seedValue: []);

  LobbyService() {
    gateway.handlers[shared.OnServerAction.createLobby] = handleLobbyCreation;
    gateway.handlers[shared.OnServerAction.enterLobby] = handleEnterLobby;
    openedLobbyRooms.listen((List<LobbyRoom> data) {
      List<shared.OpenedLobby> out = [];
      data.forEach((room) {
        out.add(room.openedLobby);
      });
      openedLobbies.add(out);
    });
  }

  LobbyRoom getLobbyRoomByPlayer(ServerPlayer player) {
    for (var lobby in openedLobbyRooms.value) {
      if (lobby.connectedPlayers.containsKey(player.email)) {
        return lobby;
      }
    }
    return null;
  }

  LobbyRoom getLobbyRoomById(String id) {
    for (var lobby in openedLobbyRooms.value) {
      if (lobby.id == id) {
        return lobby;
      }
    }
    return null;
  }

  Future<LobbyRoom> createLobbyRoom(
      ServerPlayer player, String taleName, String name) async {
    var lobbyPlayer = player.createGamePlayer();
    lobbyPlayer.humanPlayer.isGameMaster = true;

    shared.TaleCompiled tale = await getTaleByName(taleName);

    shared.OpenedLobby lobby = shared.OpenedLobby.fromLobbyTale(tale.lobby);
    lobby.players.add(lobbyPlayer);
    lobby.lobbyName = name;
    lobby.id = (lobbyId++).toString();
    print("creating lobby room ${lobby.id}");

    LobbyRoom room = LobbyRoom();
    room.compiledTale = tale;
    room.connectedPlayers[player.email] = player;
    room.openedLobby = lobby;
    openedLobbyRooms.value.add(room);
    openedLobbyRooms.add(openedLobbyRooms.value);
    room.sendUpdateToPlayer(player);
    return room;
  }

  Future<shared.TaleCompiled> getTaleByName(String name) async {
    String uri =
        makeAddressFromUri(config.editorServer.uris.first) + "inner/taleByName";
    print(jsonEncode(IdWrap.packId(name)));
    http.Response response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: IdWrap.packId(name));

    print(response.body);
    return shared.TaleCompiled.fromJson(json.decode(response.body));
  }

  void handleLobbyCreation(MessageWithConnection messageWithConnection) async {
    gateway.sendMessage(
        shared.ToClientMessage.fromSetNavigationState(
            shared.GameNavigationState.inLobby),
        messageWithConnection.player);

    shared.CreateLobby message =
        messageWithConnection.message.createLobbyMessage;

    createLobbyRoom(
        messageWithConnection.player, message.taleName, message.name);

    messageWithConnection.player.navigationState =
        shared.GameNavigationState.inLobby;
  }

  void handleEnterLobby(MessageWithConnection messageWithConnection) async {
    ServerPlayer player = messageWithConnection.player;
    gateway.sendMessage(
        shared.ToClientMessage.fromSetNavigationState(
            shared.GameNavigationState.inLobby),
        player);

    shared.EnterLobby message = messageWithConnection.message.enterLobbyMessage;

    LobbyRoom room = getLobbyRoomById(message.lobbyId);
    var lobbyPlayer = messageWithConnection.player.createGamePlayer();
    room.openedLobby.players.add(lobbyPlayer);
    room.connectedPlayers[player.email] = player;
    messageWithConnection.player.navigationState =
        shared.GameNavigationState.inLobby;
    room.sendUpdateToAllPlayers();
  }
}
