part of game_server;

class LobbyService {
  int lobbyId = 0;
  static int maximumPlayersInLobby = 4;
  BehaviorSubject<List<LobbyRoom>> openedLobbyRooms = BehaviorSubject<List<LobbyRoom>>(seedValue: []);

  BehaviorSubject<List<core.OpenedLobby>> openedLobbies = BehaviorSubject<List<core.OpenedLobby>>(seedValue: []);

  LobbyService() {
    gateway.handlers[core.OnServerAction.createLobby] = handleLobbyCreation;
    gateway.handlers[core.OnServerAction.enterLobby] = handleEnterLobby;
    openedLobbyRooms.listen((List<LobbyRoom> data) {
      List<core.OpenedLobby> out = [];
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

  Future<LobbyRoom> createLobbyRoom(ServerPlayer player, String taleName, String name) async {
    if (taleName == null) {
      return null;
    }

    var lobbyPlayer = player.createGamePlayer();
    lobbyPlayer.humanPlayer.isGameMaster = true;

    core.TaleCompiled tale = await getTaleByName(taleName);

    core.OpenedLobby lobby = core.OpenedLobby.fromLobbyTale(tale.lobby);
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

  void removeLobbyRoom(LobbyRoom room) {
    openedLobbyRooms.value.remove(room);
    openedLobbyRooms.add(openedLobbyRooms.value);
  }

  Future<core.TaleCompiled> getTaleByName(String name) async {
    String uri = makeAddressFromUri(config.editorServer.uris.first) + "inner/taleByName";
    print(jsonEncode(IdWrap.packId(name)));
    http.Response response =
        await http.post(uri, headers: {"Content-Type": "application/json"}, body: IdWrap.packId(name));

    print(response.body);
    return core.TaleCompiled.fromJson(json.decode(response.body));
  }

  void handleLobbyCreation(MessageWithConnection messageWithConnection) async {
    gateway.sendMessage(
        core.ToClientMessage.fromSetNavigationState(core.GameNavigationState.inLobby), messageWithConnection.player);

    core.CreateLobby message = messageWithConnection.message.createLobbyMessage;

    createLobbyRoom(messageWithConnection.player, message.taleName, message.name);

    messageWithConnection.player.navigationState = core.GameNavigationState.inLobby;
  }

  void handleEnterLobby(MessageWithConnection messageWithConnection) async {
    ServerPlayer player = messageWithConnection.player;

    core.EnterLobby message = messageWithConnection.message.enterLobbyMessage;

    LobbyRoom room = getLobbyRoomById(message.lobbyId);
    if(room.connectedPlayers.length >= LobbyService.maximumPlayersInLobby){
      throw "Player entering to full room";
    }
    gateway.sendMessage(core.ToClientMessage.fromSetNavigationState(core.GameNavigationState.inLobby), player);
    var lobbyPlayer = messageWithConnection.player.createGamePlayer();
    room.openedLobby.players.add(lobbyPlayer);
    room.connectedPlayers[player.email] = player;
    messageWithConnection.player.navigationState = core.GameNavigationState.inLobby;
    if(room.connectedPlayers.length == LobbyService.maximumPlayersInLobby){
      openedLobbyRooms.add(openedLobbyRooms.value..remove(room));
    }
    room.sendUpdateToAllPlayers();
  }
}
