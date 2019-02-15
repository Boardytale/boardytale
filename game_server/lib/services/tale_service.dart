part of game_server;

class TaleService{
  Map<String, ServerTale> tales = {};

  TaleService(){
    gateway.handlers[shared.OnServerAction.enterGame] = handleEnterGame;
    gateway.handlers[shared.OnServerAction.playerGameAction] = handlePlayerAction;
  }
  void handleEnterGame(MessageWithConnection message){
    String lobbyId = message.message.enterGameMessage.lobbyId;
    LobbyRoom room = lobbyService.getLobbyRoomById(lobbyId);

    ServerTale tale = ServerTale(room);

    tales[room.id] = tale;

    room.connectedPlayers.values.forEach((player){
      player.enterGame(tale);
    });
  }

  void handlePlayerAction(MessageWithConnection message){
    message.player.tale.handlePlayerAction(message);
  }
}

