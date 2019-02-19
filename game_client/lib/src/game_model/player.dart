part of client_model;

class Player {
  bool isMe = false;
  bool isEnemy = false;
  bool isDone = false;
  shared.Player sharedPlayer;

  String get name => sharedPlayer.name;

  int get color => sharedPlayer.color;

  String get meId => isMe ? "me" : isEnemy ? "enemy" : "team";
}
