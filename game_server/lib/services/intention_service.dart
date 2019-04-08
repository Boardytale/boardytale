part of game_server;

class IntentionService {
  IntentionService() {
    gateway.handlers[shared.OnServerAction.playerGameIntention] = handle;
  }

  void handle(MessageWithConnection message) {
    message.player.tale.humanPlayers.forEach((email, player) {
      if (player != message.player) {
        gateway.sendMessage(
            shared.ToClientMessage.fromIntentionUpdate(
                message.player.id, message.message.playerGameIntentionMessage.fieldsId),
            player);
      }
    });
  }
}
