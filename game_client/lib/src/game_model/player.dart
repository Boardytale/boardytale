part of client_model;

class ClientPlayer extends shared.Player{
  bool isMe = false;
  bool isEnemy = false;
  bool isDone = false;
  String get meId => isMe ? "me" : isEnemy ? "enemy" : "team";

  void fromSharedPlayer(shared.Player player) {
    id = player.id;
    name = player.name;
    team = player.team;
    color = player.color;
    gameMaster = player.gameMaster;
  }

}
