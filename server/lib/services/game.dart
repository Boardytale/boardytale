import 'package:boardytale_server/model/model.dart';
import 'package:boardytale_server/services/connection_handler.dart';
import 'package:boardytale_server/services/tale_filer.dart';
import 'package:boardytale_commons/model/model.dart' as commonLib;
import 'package:boardytale_commons/model/services/messager.dart';

class Game{
  ServerTale tale;
  String taleData;
  String name;
  bool paused = true;
  List<Player> players = [];

  Game(String taleName){
    name = taleName;
    taleData = loadTaleData(taleName);
    tale = new ServerTale(taleData);
    RegExp isHumanRegExp = new RegExp(".*[Hh]uman.*");
    tale.players.values.forEach((commonLib.Player player){
      if(isHumanRegExp.hasMatch(player.handler)){
        players.add(player);
      }
    });
  }
  bool addConnection(Connection connection){
    Player firstFreePlayer = players.firstWhere((Player player)=>player.connection==null,orElse: ()=>null);
    if(firstFreePlayer==null){
      connection.send(Messenger.error("no more space for player"));
      return false;
    }
    firstFreePlayer.connection = connection;
    sendPlayersToAll();
    sendTaleData(connection);
    return true;
  }
  void sendToAll(Map<String,dynamic> message){
    players.forEach((Player player){
      player.sendMessage(message);
    });
  }

  void sendPlayersToAll(){
    List<Map> playerMaps=players.map((Player player)=>player.toMap()).toList();
    Map<String,dynamic> message = {"type":"players","players":playerMaps};
    sendToAll(message);
  }

  void sendTaleData(Connection connection){
    connection.send({"type":"tale","tale":taleData});
  }
}