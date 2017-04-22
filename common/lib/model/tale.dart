part of model;

class Tale {
  int id;
  Map langs;
  World map;
  Map<int, Group> groups = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  Map<int, Unit> units = {};
  List<Map> unitData = [];

  void fromMap(Map data) {
    // TODO: strict validate
    id = data["id"];
    langs = data["langs"];
    map = new World()
      ..fromMap(data["map"]);
    groups.clear();
    dynamic __groups = data["groups"];
    if (__groups is List) {
      for (Map groupData in __groups) {
        Group group = new Group()
          ..fromMap(groupData);
        groups[group.id] = group;
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
    for (Trigger trigger in allTriggers) {
      if (!events.containsKey(trigger.event.name)) {
        events[trigger.event.name] = new Event();
      }
      events[trigger.event.name].triggers.add(trigger);
    }

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

}

class Group {
  int id;
  String name;
  int team;

  void fromMap(Map data) {
    id = data["id"];
    name = data["name"];
    team = data["team"];
  }
}

class Event {
  String name;
  List<Trigger> triggers;
}

class Trigger {
  Call event;
  Call action;

  fromMap(Map data) {
    event = new Call(data["event"]);
    action = new Call(data["action"]);
  }
}

class Dialog {
  String name;
  Call image;

  void fromMap(Map data) {
    name = data["name"];
    image = new Call(data["image"]);
  }
}