part of game_server;

class LobbyRoom {
  BehaviorSubject<shared.OpenedLobby> openedLobby =
      BehaviorSubject<shared.OpenedLobby>();
  List<ServerPlayer> connectedPlayers = [];

  LobbyRoom() {
    openedLobby.listen((onData) {
      connectedPlayers.forEach((player) {
        gateway.sendMessage(
            shared.ToClientMessage.fromOpenedLobby(onData), player);
      });
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
