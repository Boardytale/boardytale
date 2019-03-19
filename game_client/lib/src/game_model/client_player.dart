part of client_model;

class ClientPlayer extends shared.Player {
  String get name => isHumanPlayer ? humanPlayer.name : aiGroup.langName.values.first;

  void fromSharedPlayer(shared.Player player) {
    id = player.id;
    team = player.team;
    color = player.color;
    if (player.isHumanPlayer) {
      humanPlayer = shared.HumanPlayer();
      humanPlayer.isGameMaster = player.humanPlayer.isGameMaster;
      humanPlayer.name = player.humanPlayer.name;
    }
    if (player.isAiPlayer) {
      aiGroup = shared.AiGroup();
      aiGroup.langName = player.aiGroup.langName;
    }
  }
}
