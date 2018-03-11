part of model;

class Tale {
  String id;
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
    id = data["id"].toString();
    langs = data["langs"] as Map;
    humanPlayersTeam = data["humanPlayersTeam"] as int;
    map = new World()
      ..fromMap(data["map"] as Map);
    players.clear();
    dynamic __groups = data["groups"];
    if (__groups is List) {
      for (Map<String,dynamic> playerData in __groups) {
        Player player = new Player()
          ..fromMap(playerData);
        players[player.id] = player;
      }
    }

    List<Trigger> allTriggers = [];
    dynamic __triggers = data["triggers"];
    if (__triggers is List) {
      for (Map triggerData in __triggers) {
        allTriggers.add(new Trigger()..fromMap(triggerData));
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
        Dialog dialog = new Dialog()
          ..fromMap(dialogData);
        dialogs[dialog.name] = dialog;
      }
    }

    units.clear();
    dynamic __units = data["units"];
    if (__units is List) {
      unitData = __units;
    }
  }

  Map toMap() {
    Map<String,dynamic> out = <String,dynamic>{};
    out["id"] = id;
    out["langs"] = langs;
    out["groups"] = players.values.map((g)=>g.toMap()).toList();
    out["humanPlayersTeam"] = humanPlayersTeam;
    out["dialogs"] = dialogs.values.map((d)=>d.toMap()).toList();
    out["units"] = unitData;
    out["map"] = map.toMap();
    List<Map<String,dynamic>> triggers = [];
    events.forEach((k,v){
      v.triggers.forEach((t)=>triggers.add(t.toMap()));
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

  Map<String,dynamic> toMap() {
    return <String,dynamic>{
      "event": event.toString(),
      "action": action.toString()
    };
  }
}

class Dialog {
  String name;
  Call image;

  void fromMap(Map data) {
    name = data["name"] as String;
    image = new Call(data["image"] as String);
  }

  Map<String,dynamic> toMap() {
    return <String,dynamic>{
      "name": name,
      "image": image.toString()
    };
  }
}