part of boardytale.server.model;

class Player extends model_lib.Player {
  Connection _connection;
  bool roundDone=false;


  Player() {
  }
  Connection get connection => _connection;

  void set connection(Connection connection) {
    _connection = connection;
    connection.listen("whoami", (_){
      sendMessage(toMap());
    });
    connection.onClose.add((){
      _connection=null;
    });
  }

  bool sendMessage(Map<String,dynamic> message){
    if(connection==null) return false;
    return connection.send(message);
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> result = super.toMap();
    result["connection"]=connection?.name;
    return result;
  }

  void sendCancel(String reason,Map<String,dynamic> original){
    if(connection==null) return;
    connection.send({"type":"cancel","original":original,"reason":reason});
  }
}
