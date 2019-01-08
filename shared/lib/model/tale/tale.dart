part of model;

class Tale {
  String id;
  Map langs;
  int humanPlayersTeam;
  World world;
  Map<String, Player> players = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  Map<String, Unit> units = {};
  Resources resources;

  Tale(this.resources);

//  void fromMap(Map data) {
//    // TODO: strict validate
//    id = data["id"].toString();
//    langs = data["langs"] as Map;
//    humanPlayersTeam = data["humanPlayersTeam"] as int;
//    InstanceGenerator generator = resources.generator;
//    world = generator.world(this)..fromMap(data["map"] as Map, generator);
//    players.clear();
////    dynamic __groups = data["players"];
////    if (__groups is List) {
////      for (Map<String, dynamic> playerData in __groups) {
////        Player player = Player.fromJson(playerData);
////        players[player.id.toString()] = player;
////      }
////    }
//
//    List<Trigger> allTriggers = [];
//    dynamic __triggers = data["implicitTriggers"];
//    if (__triggers is List) {
//      for (Map triggerData in __triggers) {
//        allTriggers.add(Trigger.fromJson(triggerData));
//      }
//    }
//    events.clear();
////    for (Trigger trigger in allTriggers) {
//////      String name = trigger.event.name;
//////      if (!events.containsKey(name)) {
//////        events[name] = new Event(name);
//////      }
//////      events[name].implicitTriggers.add(trigger);
////    }
//
//    dialogs.clear();
//    dynamic __dialogs = data["dialogs"];
//    if (__dialogs is List) {
//      for (Map dialogData in __dialogs) {
//        Dialog dialog = Dialog.fromJson(dialogData);
//        dialogs[dialog.name] = dialog;
//      }
//    }
//
//    units.clear();
//    dynamic __units = data["units"];
//    if (__units is List) {
//      int unitId = 0;
//      for (Map m in __units) {
//        String typeId = m["type"].toString();
//        if (!resources.unitTypes.containsKey(typeId)) throw "Type $typeId is not defined";
//        Unit unit = resources.generator.unit((unitId++).toString())..fromMap(m, this);
//        units[unit.id] = unit;
//      }
//    }
//  }

//  void update(Map<String, dynamic> state) {
//    List<Map<String, dynamic>> unitMapList = state["units"];
//    Map<String, Unit> oldUnits = units;
//    units = {};
//    for (Map<String, dynamic> unitMap in unitMapList) {
//      Unit unit = oldUnits[unitMap["id"]];
//      if (unit == null) {
//        UnitType type = resources.unitTypes[unitMap["type"]];
//        if (type == null) {
//          print("ERROR - missing unitType");
//          continue;
//        }
//        unit = resources.generator.unit(unitMap["id"]);
//      }
//      units[unit.id] = unit..fromMap(unitMap, this);
//    }
//    List<Map<String, dynamic>> playerMapList = state["players"];
//    for (Map<String, dynamic> playerMap in playerMapList) {
//      Player player = players[playerMap["id"]];
//      player?.fromMap(playerMap);
//    }
//  }
//
//  Map toMap() {
//    Map<String, dynamic> out = <String, dynamic>{};
//    out["id"] = id;
//    out["langs"] = langs;
////    out["players"] = players.values.map((g) => g.toMap()).toList();
//    out["humanPlayersTeam"] = humanPlayersTeam;
//    out["dialogs"] = dialogs.values.map((d) => d.toMap()).toList();
//    out["units"] = units.values.map((Unit unit) => unit.toSimpleJson()).toList(growable: false);
//    out["map"] = world.toMap();
//    List<Map<String, dynamic>> triggers = [];
//    events.forEach((k, v) {
//      v.triggers.forEach((t) => triggers.add(t.toMap()));
//    });
//    out["implicitTriggers"] = triggers;
//    return out;
//  }
}

@Typescript()
@JsonSerializable()
class Event {
  String name;
  List<Trigger> triggers = [];

  Event(this.name);

  static Event fromJson(Map json) {
    return _$EventFromJson(json);
  }
}

@Typescript()
@JsonSerializable()
class Trigger {
  Call event;
  Call action;

  static Trigger fromJson(Map data) {
    return _$TriggerFromJson(data);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"event": event.toString(), "action": action.toString()};
  }
}

@Typescript()
@JsonSerializable()
class Dialog {
  String name;
  Call image;

  static Dialog fromJson(Map<String, dynamic> json) {
    return _$DialogFromJson(json);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"name": name, "image": image.toString()};
  }
}

@Typescript()
@JsonSerializable()
class Call {
  String name;
  List arguments;

  Call();

  Call.fromLiteral(String literal) {
//    int argumentsStart = literal.indexOf("(");
//    int argumentsEnd = literal.indexOf(")");
//    name = literal.substring(0,argumentsStart);
//    arguments = literal.substring(argumentsStart+1, argumentsEnd).split(",");
  }

  static Call fromJson(Map<String, dynamic> json) {
    return _$CallFromJson(json);
  }

  @override
  String toString() {
    return '';
//     return "$name(${arguments.join(",")})";
  }
}
