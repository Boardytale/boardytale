part of boardytale.server.lobby;

typedef void ConnectionListenCallback(Map<String,dynamic> message);

class Connection {
  WebSocketChannel channel;
  String name;
  bool isClosed=false;
  Map<String,List<ConnectionListenCallback>> callbackGroups={};
  Notificator onClose = new Notificator();

  Connection(this.channel) {
    name = "Socket: ${channel.hashCode}";
    listen("ping", (Map<String,dynamic> message)=>send(message));
    channel.stream.listen((message) {
      Map<String,dynamic> messageMap = parseJsonMap(message);
      if(!messageMap.containsKey("type")){
        send({"type":"message","message":"Missing \"type\" key"});
        return;
      }
      List<ConnectionListenCallback> group = callbackGroups[messageMap["type"]];
      if(group==null) return;
      group.forEach((ConnectionListenCallback callback){
        callback(messageMap);
      });
    }, onDone: () {
      close();
    }, onError: () {
      close();
    });
  }

  bool send(Map<String, dynamic> message) {
    print("sending ${message} to ${name}");
    if(isClosed) return false;
    channel.sink.add(JSON.encode(message));
    return true;
  }
  void listen(String type,ConnectionListenCallback callback){
    if(!callbackGroups.containsKey(type)){
      callbackGroups[type]=[];
    }
    callbackGroups[type].add(callback);
  }

  void close(){
    isClosed=true;
    callbackGroups.forEach((_,List group){
      group.clear();
    });
    onClose.notify();
    onClose.clear();
  }
}
