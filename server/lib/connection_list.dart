part of boardytale.server;
class ConnectionList{
  Map<String, Connection> connections = {};

  void add(Connection connection){
    connections[connection.name]=connection;
    updateOthers();
  }
  void remove(Connection connection){
    connections.remove(connection.name);
    updateOthers();
  }
  void updateOthers() {
    var socketMessage = JSON.encode({"sockets": connections.keys.toList(growable: false)});
    for (Connection c in connections.values) {
      c.channel.sink.add(socketMessage);
    }
  }
}