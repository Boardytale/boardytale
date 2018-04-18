part of model;

class Tale {
  String id;
  int humanPlayersTeam;
  Map langs;
  World world;
  Resources resources;
  Map<int, Player> players = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  Map<String, Unit> units = {};

  Tale(this.resources);

  void fromMap(Map data) {
    // TODO: strict validate
    id = data["id"].toString();
    langs = data["langs"] as Map;
    humanPlayersTeam = data["humanPlayersTeam"] as int;
    InstanceGenerator generator = resources.generator;
    world = generator.world(this)..fromMap(data["map"] as Map, generator);
    players.clear();
    dynamic __groups = data["players"];
    if (__groups is List) {
      for (Map<String, dynamic> playerData in __groups) {
        Player player = generator.player()..fromMap(playerData);
        players[player.id] = player;
      }
    }

    List<Trigger> allTriggers = [];
    dynamic __triggers = data["triggers"];
    if (__triggers is List) {
      for (Map triggerData in __triggers) {
        allTriggers.add(generator.trigger()..fromMap(triggerData));
      }
    }
    events.clear();
//    for (Trigger trigger in allTriggers) {
////      String name = trigger.event.name;
////      if (!events.containsKey(name)) {
////        events[name] = new Event(name);
////      }
////      events[name].triggers.add(trigger);
//    }

    dialogs.clear();
    dynamic __dialogs = data["dialogs"];
    if (__dialogs is List) {
      for (Map dialogData in __dialogs) {
        Dialog dialog = generator.dialog()..fromMap(dialogData);
        dialogs[dialog.name] = dialog;
      }
    }

    units.clear();
    dynamic __units = data["units"];
    if (__units is List) {
      int unitId = 0;
      for (Map m in __units) {
        String typeId = m["type"].toString();
        if (!resources.unitTypes.containsKey(typeId)) throw "Type $typeId is not defined";
        Unit unit = resources.generator.unit((unitId++).toString())..fromMap(m, this);
        units[unit.id] = unit;
      }
    }
  }

  void update(Map<String, dynamic> state) {
    List<Map<String, dynamic>> unitMapList = state["units"];
    Map<String, Unit> oldUnits = units;
    units = {};
    for (Map<String, dynamic> unitMap in unitMapList) {
      Unit unit = oldUnits[unitMap["id"]];
      if (unit == null) {
        UnitType type = resources.unitTypes[unitMap["type"]];
        if (type == null) {
          print("ERROR - missing unitType");
          continue;
        }
        unit = resources.generator.unit(unitMap["id"]);
      }
      units[unit.id] = unit..fromMap(unitMap, this);
    }
    List<Map<String, dynamic>> playerMapList = state["players"];
    for (Map<String, dynamic> playerMap in playerMapList) {
      Player player = players[playerMap["id"]];
      player?.fromMap(playerMap);
    }
  }

  Map toMap() {
    Map<String, dynamic> out = <String, dynamic>{};
    out["id"] = id;
    out["langs"] = langs;
    out["players"] = players.values.map((g) => g.toMap()).toList();
    out["humanPlayersTeam"] = humanPlayersTeam;
    out["dialogs"] = dialogs.values.map((d) => d.toMap()).toList();
    out["units"] = units.values.map((Unit unit) => unit.toSimpleJson()).toList(growable: false);
    out["map"] = world.toMap();
    List<Map<String, dynamic>> triggers = [];
    events.forEach((k, v) {
      v.triggers.forEach((t) => triggers.add(t.toMap()));
    });
    out["triggers"] = triggers;
    return out;
  }
}

class Event {
  String name;
  List<Trigger> triggers = [];

  Event(this.name);
}

class Trigger {
  Call event;
  Call action;

  void fromMap(Map data) {
//    event = new Call(data["event"]);
//    action = new Call(data["action"]);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"event": event.toString(), "action": action.toString()};
  }
}

class Dialog {
  String name;
  Call image;

  void fromMap(Map data) {
    name = data["name"] as String;
    image = new Call(data["image"] as String);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"name": name, "image": image.toString()};
  }
}
