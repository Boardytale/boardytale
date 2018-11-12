part of client_model;

class Player extends commonModel.Player {
  String connectionName;
  bool isMe=false;
  bool isEnemy=false;

  String get meId =>isMe?"me":isEnemy?"enemy":"team";

  void fromMap(Map<String, dynamic> data) {
    super.fromMap(data);
    connectionName = data["connection"];
  }
}
