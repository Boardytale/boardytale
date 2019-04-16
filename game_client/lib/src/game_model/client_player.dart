part of client_model;

class ClientPlayer extends core.Player {
  String get name => isHumanPlayer ? humanPlayer.name : aiGroup.langName.values.first;

  void fromCorePlayer(core.Player player) {
    id = player.id;
    team = player.team;
    color = player.color;
    if (player.isHumanPlayer) {
      humanPlayer = core.HumanPlayer();
      humanPlayer.isGameMaster = player.humanPlayer.isGameMaster;
      humanPlayer.name = player.humanPlayer.name;
    }
    if (player.isAiPlayer) {
      aiGroup = core.AiGroup();
      aiGroup.langName = player.aiGroup.langName;
    }
  }
}
