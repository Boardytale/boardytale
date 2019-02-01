part of game_server;

class LobbyRoom {
  ServerGateway gateway;

  LobbyRoom(this.gateway) {
    lobbyList.onLobbiesChanged.listen((lobbies){
      gateway.sendMessage(shared.ToClientMessage.fromRefreshLobbyList(lobbies));
    });
  }
}


final LobbyList lobbyList = new LobbyList._private();

class LobbyList {
  BehaviorSubject<List<shared.LobbyTale>> onLobbiesChanged = new BehaviorSubject<List<shared.LobbyTale>>(seedValue: []);
  List<shared.LobbyTale> lobbies = [];
  LobbyList._private();

  void addLobby(shared.LobbyTale lobby){
    lobbies.add(lobby);
    onLobbiesChanged.add(lobbies);
  }
}
