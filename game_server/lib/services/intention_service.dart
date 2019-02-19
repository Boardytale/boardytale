part of game_server;

class IntentionService {
  IntentionService() {
    gateway.handlers[shared.OnServerAction.playerGameIntention] = handle;
  }

  void handle(MessageWithConnection message) {
    String fieldId = message.message.playerGameIntentionMessage.fieldId;
    message.player.tale.players.forEach((email, player){
      if(player != message.player){
        gateway.sendMessage(shared.ToClientMessage.fromIntentionUpdate(player.id, fieldId), player);
      }
    });
  }
}
