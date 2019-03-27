part of game_server;

class LobbyRoom {
  bool gameRunning = false;
  shared.TaleCompiled compiledTale;

  String get id => openedLobby.id;
  shared.OpenedLobby openedLobby;
  ServerTale tale;

  // by email
  Map<String, ServerPlayer> connectedPlayers = {};

  LobbyRoom() {
    //    openedLobby.listen((onData) {
    //      connectedPlayers.forEach((player) {
    //        gateway.sendMessage(
    //            shared.ToClientMessage.fromOpenedLobby(onData), player);
    //      });
    //    });
  }

  void sendUpdateToPlayer(ServerPlayer player) {
    if (gameRunning && player.tale != null) {
      return;
    }
    gateway.sendMessage(shared.ToClientMessage.fromOpenedLobby(openedLobby), player);
  }

  void sendUpdateToAllPlayers() {
    connectedPlayers.values.forEach(sendUpdateToPlayer);
  }

  void destroy() {
    connectedPlayers.forEach((key, player){
      player.leaveRoom();
    });
    connectedPlayers = null;
    lobbyService.removeLobbyRoom(this);
    print("destroyed lobby room ${id}");
  }
}

final LobbyList lobbyList = new LobbyList._private();

class LobbyList {
  BehaviorSubject<List<shared.LobbyTale>> onLobbiesChanged = new BehaviorSubject<List<shared.LobbyTale>>(seedValue: []);
  List<shared.LobbyTale> lobbies = [];

  LobbyList._private();

  void addLobby(shared.LobbyTale lobby) {
    lobbies.add(lobby);
    onLobbiesChanged.add(lobbies);
  }
}
