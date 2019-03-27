part of ai_server;

class ServerGateway {
  Map<String, AiTale> tales = {};

  void sendMessage(shared.ToClientMessage message, Connection connection) {
    connection.socket.write(json.encode(message.toJson()));
  }

  void incomingMessage(MessageWithConnection messageWithConnection) async {
    if(messageWithConnection.message.message == shared.OnAiServerAction.getNextMoveByState){
      tales[messageWithConnection.connection.id.toString()] = AiTale(messageWithConnection.message.getNextMoveByState);
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
