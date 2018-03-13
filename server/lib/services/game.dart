import 'package:boardytale_server/model/model.dart';
import 'package:boardytale_server/services/connection_handler.dart';
import 'package:boardytale_server/services/tale_filer.dart';
import 'package:boardytale_commons/model/model.dart' as commonLib;
import 'package:boardytale_commons/model/services/messager.dart';
import 'package:tales_compiler/tales_compiler.dart';
import 'package:utils/utils.dart';

class Game {
  ServerTale tale;
  String taleData;
  String name;
  bool paused = true;
  List<Player> players = [];

  Game(String taleName) {
    name = taleName;
    taleData = loadTaleData(taleName);
    Map data = parseJsonMap(taleData);
    tale = TaleAssetsPack.unpack(data, new ServerClassGenerator());
    RegExp isHumanRegExp = new RegExp(".*[Hh]uman.*");
    tale.players.values.forEach((commonLib.Player player) {
      if (isHumanRegExp.hasMatch(player.handler)) {
        players.add(player);
      }
    });
  }
  bool addConnection(Connection connection) {
    Player firstFreePlayer = players.firstWhere((Player player) => player.connection == null, orElse: () => null);
    if (firstFreePlayer == null) {
      connection.send(Messenger.error("no more space for player"));
      return false;
    }
    firstFreePlayer.connection = connection;
    connection.send({"type": "connection", "name": connection.name});
    sendPlayersToAll();
    connection.send({"type": "tale", "tale": taleData});
    return true;
  }

  void sendToAll(Map<String, dynamic> message) {
    players.forEach((Player player) {
      player.sendMessage(message);
    });
  }

  void sendPlayersToAll() {
    List<Map> playerMaps = players.map((Player player) => player.toMap()).toList();
    Map<String, dynamic> message = {"type": "players", "players": playerMaps};
    sendToAll(message);
  }

  void sendStateForAll(){
    Map<String,dynamic> data={"type":"state"};
    data["units"]=tale.units.values.map((commonLib.Unit unit)=>unit.toSimpleJson()).toList();
    sendToAll(data);
  }

  void testMove1(){
    commonLib.Field target = tale.map.fields["1_1"];
    commonLib.Unit unit = tale.units[0];
    unit.move(target,target.distance(unit.field));
  }
}
