part of model;

class Tale {
  int id;
  int humanPlayersTeam;
  Map langs;
  World map;
  Map<int, Player> players = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  Map<int, Unit> units = {};
  List<Map> unitData = [];

  void fromMap(Map data) {
    // TODO: strict validate
    id = data["id"];
    langs = data["langs"];
    humanPlayersTeam = data["humanPlayersTeam"];
    map = new World()
      ..fromMap(data["map"]);
    players.clear();
    dynamic __groups = data["groups"];
    if (__groups is List) {
      for (Map playerData in __groups) {
        Player player = new Player()
          ..fromMap(playerData);
        players[player.id] = player;
      }
    }

    List<Trigger> allTriggers = [];
    dynamic __triggers = data["implicitTriggers"];
    if (__triggers is List) {
      for (Map triggerData in __triggers) {
        allTriggers.add(new Trigger()..fromMap(triggerData));
      }
    }
    events.clear();
    for (Trigger trigger in allTriggers) {
//      String name = trigger.event.name;
//      if (!events.containsKey(name)) {
//        events[name] = new Event(name);
//      }
//      events[name].implicitTriggers.add(trigger);
    }

    dialogs.clear();
    dynamic __dialogs = data["dialogs"];
    if (__dialogs is List<Map>) {
      for (Map dialogData in __dialogs) {
        Dialog dialog = new Dialog()
          ..fromMap(dialogData);
        dialogs[dialog.name] = dialog;
      }
    }

    units.clear();
    dynamic __units = data["units"];
    if (__units is List<Map>) {
      unitData = __units;
    }
  }

  Map toMap() {
    Map out = {};
    out["id"] = id;
    out["langs"] = langs;
    out["groups"] = players.values.map((g)=>g.toMap()).toList();
    out["humanPlayersTeam"] = humanPlayersTeam;
    out["dialogs"] = dialogs.values.map((d)=>d.toMap()).toList();
    out["units"] = unitData;
    out["map"] = map.toMap();
    List triggers = [];
    events.forEach((k,v){
      v.triggers.forEach((t)=>triggers.add(t.toMap()));
    });
    out["implicitTriggers"] = triggers;
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

  fromMap(Map data) {
//    event = new Call(data["event"]);
//    action = new Call(data["action"]);
  }

  Map toMap() {
    return{
      "event": event.toString(),
      "action": action.toString()
    };
  }
}

class Dialog {
  String name;
  Call image;

  void fromMap(Map data) {
    name = data["name"];
    image = new Call(data["image"]);
  }

  Map toMap() {
    return {
      "name": name,
      "image": image.toString()
    };
  }
}