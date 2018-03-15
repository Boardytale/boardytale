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
  Clock clock;

  List<Player> players = [];

  Game(String taleName) {
    name = taleName;
    taleData = loadTaleData(taleName);
    Map data = parseJsonMap(taleData);
    tale = TaleAssetsPack.unpack(data, new ServerInstanceGenerator());
    RegExp isHumanRegExp = new RegExp(".*[Hh]uman.*");
    tale.players.values.forEach((commonLib.Player player) {
      if (isHumanRegExp.hasMatch(player.handler)) {
        players.add(player);
      }
    });
    clock=new Clock(players,tale);
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

  void handleCommands(Player player) {
    player.connection.listen("command", (Map<String, dynamic> message) {
      void cancel(String reason){
        return player.sendCancel(reason, message);
      }
      if(!clock.isPlayerPlaying(player)) return cancel("player is not playing");
      commonLib.Unit unit = tale.units[message["unit"]];
      if (unit == null) return cancel("no unit");
      if (!unit.isAlive) return cancel("unit is dead");
      commonLib.Field origin = tale.world.fields[message["origin"]];
      if (origin == null) return cancel("no origin");
      if (origin != unit.field) return cancel("unit dont stand on origin");
      commonLib.Field target = tale.world.fields[message["target"]];
      if (target == null) return cancel("no target");
      switch (message["command"]) {
        case "move":
          int steps = target.distance(origin);
          if(unit.steps< steps) return cancel("too few steps");
          unit.move(target, steps);
          return sendStateForAll();
        default:
          return cancel("too few steps");
      }
    });
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

  void sendStateForAll() {
    Map<String, dynamic> data = {"type": "state"};
    data["units"] = tale.units.values.map((commonLib.Unit unit) => unit.toSimpleJson()).toList();
    sendToAll(data);
  }

  void testMove(int unitIndex, int direction) {
    commonLib.Unit unit = tale.units[unitIndex];
    commonLib.Field target = tale.world.fields[unit.field.stepToDirection(direction)];
    unit.move(target, target.distance(unit.field));
    sendStateForAll();
  }
}
