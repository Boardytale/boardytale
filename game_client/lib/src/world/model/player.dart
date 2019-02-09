part of client_model;

class Player extends shared.GamePlayer {
  String connectionName;
  bool isMe = false;
  bool isEnemy = false;
  bool isDone = false;

  String get meId => isMe ? "me" : isEnemy ? "enemy" : "team";

  Player fromMap(Map<String, dynamic> data) {
    Player newPlayer = shared.GamePlayer.fromJson(data);
    newPlayer.connectionName = data["connection"];
    return newPlayer;
  }
}
