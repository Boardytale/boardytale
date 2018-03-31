import 'package:boardytale_server/model/abilities/abilities.dart';
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
    clock.onNextTeam.add((){
      sendStateForAll();
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
    connection.send({"type": "tale", "tale": taleData});
    sendStateForAll();
    handleCommands(firstFreePlayer);
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
//      if (unit.player != player) return cancel("unit belongs to different player");
      if (!unit.isAlive) return cancel("unit is dead");
      dynamic dynamicPath = message["path"];
      if(dynamicPath == null) return cancel("missing path");
      if(dynamicPath is! Iterable) return cancel("malformed path");
      commonLib.Track track = new commonLib.Track.fromIds(dynamicPath, tale);
      if(!track.isConnected) return cancel("non-continuous path");
      if (track.first != unit.field) return cancel("unit dont stand on origin");
      commonLib.Ability ability = unit.getAbilityByName(message["ability"]);
      if(ability is! ServerAbility) return cancel(ability.className+" is not ServerAbility");
      String abilityValidation = ability.validate(unit, track);
      if(abilityValidation!=null) return cancel(abilityValidation);
      (ability as ServerAbility).perform(unit,track);
      return sendStateForAll();
    });
  }

  void sendToAll(Map<String, dynamic> message) {
    players.forEach((Player player) {
      player.sendMessage(message);
    });
  }

  void sendStateForAll() {
    Map<String, dynamic> data = {"type": "state","playing":clock.teamPlaying};
    data["units"] = tale.units.values.map((commonLib.Unit unit) => unit.toSimpleJson()).toList();
    data["players"] = tale.players.values.map((commonLib.Player player) => player.toMap()).toList();
    sendToAll(data);
  }

}
