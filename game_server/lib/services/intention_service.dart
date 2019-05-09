part of game_server;

class IntentionService {
  IntentionService() {
    gateway.handlers[core.OnServerAction.playerGameIntention] = handle;
  }

  void handle(MessageWithConnection message) {
    if(message.player.tale != null){
      message.player.tale.taleState.humanPlayers.forEach((email, player) {
        if (player != message.player) {
          gateway.sendMessage(
              core.ToClientMessage.fromIntentionUpdate(
                  message.player.id, message.message.playerGameIntentionMessage.fieldsId),
              player);
        }
      });
    }
  }
}
