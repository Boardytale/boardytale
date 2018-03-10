part of boardytale.server;

class Connection {
  WebSocketChannel channel;
  String name;

  Connection(this.channel) {
    name = "Socket: ${channel.hashCode}";
    channel.sink.add(JSON.encode({"name": name}));
    connections.add(this);
    channel.stream.listen((message) {
      channel.sink.add(message);
    }, onDone: () {
      connections.remove(this);
    }, onError: () {
      connections.remove(this);
    });
  }
}
