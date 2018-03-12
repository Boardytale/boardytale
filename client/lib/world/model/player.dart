part of client_model;

class Player extends commonModel.Player {
  String connectionName;

  void fromMap(Map<String, dynamic> data) {
    super.fromMap(data);
    connectionName = data["connection"];
  }
}
