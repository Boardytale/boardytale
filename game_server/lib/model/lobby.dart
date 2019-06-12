part of game_server;

class LobbyRoom {
  bool gameRunning = false;
  bool closedForNewPlayers = false;
  core.TaleCompiled compiledTale;

  String get id => openedLobby.id;
  core.OpenedLobby openedLobby;
  ServerTale tale;

  // by email
  Map<String, ServerPlayer> connectedPlayers = {};

  LobbyRoom() {
    //    openedLobby.listen((onData) {
    //      connectedPlayers.forEach((player) {
    //        gateway.sendMessage(
    //            core.ToClientMessage.fromOpenedLobby(onData), player);
    //      });
    //    });
  }

  void sendUpdateToPlayer(ServerPlayer player) {
    if (gameRunning && player.tale != null) {
      return;
    }
    gateway.sendMessage(core.ToClientMessage.fromOpenedLobby(openedLobby), player);
  }

  void sendUpdateToAllPlayers() {
    connectedPlayers.values.forEach(sendUpdateToPlayer);
  }

  void destroy() {
    connectedPlayers.forEach((key, player) {
      player.leaveRoom();
    });
    connectedPlayers.clear();
    lobbyService.removeLobbyRoom(this);
  }

  void ejectPlayer(ServerPlayer player) {
    if (openedLobby != null) {
      openedLobby.players.removeWhere((p) => p.id == player.id);
    }
    connectedPlayers.remove(player.email);
    if (tale != null) {
      tale.ejectPlayer(player);
      if (connectedPlayers.isEmpty) {
        tale.destroy();
      }
    }
    print("player ejected ${player.email}");
    sendUpdateToAllPlayers();
  }
}

final LobbyList lobbyList = new LobbyList._private();

class LobbyList {
  BehaviorSubject<List<core.LobbyTale>> onLobbiesChanged = new BehaviorSubject<List<core.LobbyTale>>(seedValue: []);
  List<core.LobbyTale> lobbies = [];

  LobbyList._private();

  void addLobby(core.LobbyTale lobby) {
    lobbies.add(lobby);
    onLobbiesChanged.add(lobbies);
  }
}
