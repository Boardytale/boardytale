part of game_server;

class LobbyService {
  int lobbyId = 0;
  static int maximumPlayersInLobby = 4;
  BehaviorSubject<List<LobbyRoom>> openedLobbyRooms = BehaviorSubject<List<LobbyRoom>>(seedValue: []);

  LobbyService() {
    gateway.handlers[core.OnServerAction.createLobby] = handleLobbyCreation;
    gateway.handlers[core.OnServerAction.enterLobby] = handleEnterLobby;
    openedLobbyRooms.listen((List<LobbyRoom> data) {
      print("opened lobby rooms changed ${openedLobbyRooms.value.map((v) => v.openedLobby.lobbyName).join(" ")}");
    });
  }

  List<core.OpenedLobby> getOpenedRoomsClientData() {
    return openedLobbyRooms.value.map((room) => room.openedLobby).toList();
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
    if (room.connectedPlayers.length >= LobbyService.maximumPlayersInLobby) {
      throw "Player entering to full room";
    }

    var lobbyPlayer = messageWithConnection.player.createGamePlayer();
    room.openedLobby.players.add(lobbyPlayer);
    room.connectedPlayers[player.email] = player;
    if (room.connectedPlayers.length == LobbyService.maximumPlayersInLobby) {
      removeLobbyRoom(room);
    }
    if (room.gameRunning) {
      player.enterGame(room.tale);
      room.tale.addHumanPlayer(player);
      room.tale.sendTaleDataToPlayer(player);
      HeroesHelper.getHeroes([player], room.connectedPlayers.values, room.tale);
      messageWithConnection.player.navigationState = core.GameNavigationState.inGame;
    } else {
      messageWithConnection.player.navigationState = core.GameNavigationState.inLobby;
    }
    gateway.sendMessage(
        core.ToClientMessage.fromSetNavigationState(messageWithConnection.player.navigationState), player);
    room.sendUpdateToAllPlayers();
  }
}
