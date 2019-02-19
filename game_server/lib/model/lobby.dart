part of game_server;

class LobbyRoom {
  shared.TaleCompiled compiledTale;
  String get id => openedLobby.id;
  shared.OpenedLobby openedLobby;
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
    gateway.sendMessage(
        shared.ToClientMessage.fromOpenedLobby(openedLobby), player);
  }

  void sendUpdateToAllPlayers() {
    connectedPlayers.values.forEach((player){
      gateway.sendMessage(
          shared.ToClientMessage.fromOpenedLobby(openedLobby), player);
    });
  }
}

final LobbyList lobbyList = new LobbyList._private();

class LobbyList {
  BehaviorSubject<List<shared.LobbyTale>> onLobbiesChanged =
      new BehaviorSubject<List<shared.LobbyTale>>(seedValue: []);
  List<shared.LobbyTale> lobbies = [];

  LobbyList._private();

  void addLobby(shared.LobbyTale lobby) {
    lobbies.add(lobby);
    onLobbiesChanged.add(lobbies);
  }
}
