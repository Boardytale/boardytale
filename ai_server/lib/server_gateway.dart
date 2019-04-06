part of ai_server;

class ServerGateway {
  Map<String, AiTale> tales = {};

  void sendMessage(shared.ToGameServerMessage message, Connection connection) {
    print("ai out ${json.encode(message.toJson())}");
    connection.socket.write(json.encode(message.toJson()));
  }

  void incomingMessage(MessageWithConnection messageWithConnection) async {
    print("ai in ${json.encode(messageWithConnection.message.toJson())}");
    if(messageWithConnection.message.message == shared.OnAiServerAction.getNextMoveByState){
      tales[messageWithConnection.connection.id.toString()] = AiTale(messageWithConnection.message.getNextMoveByState, messageWithConnection.connection)..nextMove();
    }
    if(messageWithConnection.message.message == shared.OnAiServerAction.getNextMoveByUpdate){
      tales[messageWithConnection.connection.id.toString()]..applyPatch(messageWithConnection.message.getNextMoveByUpdate)..nextMove();
    }
  }
}

class Connection {
  int id;
  io.Socket socket;
}

class MessageWithConnection {
  shared.ToAiServerMessage message;
  Connection connection;
}
