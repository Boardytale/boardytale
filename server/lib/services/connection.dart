part of boardytale.server.lobby;

typedef void ConnectionListenCallback(Map<String, dynamic> message);

class Connection {
  WebSocketChannel channel;
  String name;
  bool isClosed = false;
  Map<String, List<ConnectionListenCallback>> callbackGroups = {};
  Notificator onClose = new Notificator();

  Connection(this.channel) {
    name = "Socket: ${channel.hashCode}";
    listen("ping", (Map<String, dynamic> message) => send(message));
    channel.stream
        .map((data) => parseJsonMap(data.toString()))
        .listen(
        onMessage, onDone: close, onError: close);
  }

  void onMessage(Map<String,dynamic> message) {
    if (!message.containsKey("type")) {
      send({"type": "message", "message": "Missing \"type\" key"});
      return;
    }
    List<ConnectionListenCallback> group = callbackGroups[message["type"]];
    // TODO: get rid of all messages doing nothing
    if (group == null) return;
    group.forEach((ConnectionListenCallback callback) {
      callback(message);
    });
  }

  bool send(Map<String, dynamic> message) {
    if (isClosed) return false;
    channel.sink.add(JSON.encode(message));
    return true;
  }

  void listen(String type, ConnectionListenCallback callback) {
    if (!callbackGroups.containsKey(type)) {
      callbackGroups[type] = [];
    }
    callbackGroups[type].add(callback);
  }

  void close([_]) {
    isClosed = true;
    callbackGroups.forEach((_, List group) {
      group.clear();
    });
    onClose.notify();
    onClose.clear();
  }
}
