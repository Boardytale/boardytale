part of model;

@Typescript()
class Tale {
  String name;
  Map<Lang, Map<String, String>> langs;
  Map<Lang, String> langName;
  int humanPlayersTeam;
  covariant World world;
  covariant Map<String, Player> players = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  Map<String, Unit> units = {};

  void fromCompiledTale(TaleInnerCompiled tale) {
    name = tale.name;
    langs = tale.langs;
    world = World()..fromEnvelope(tale.world);
    events = tale.events;
    dialogs = tale.dialogs;
  }

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

  Map toJson() {
    return _$EventToJson(this);
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

  Map<String, dynamic> toJson() {
    return _$TriggerToJson(this);
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

  Map<String, dynamic> toJson() {
    return _$DialogToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class Call {
  String name;
  List arguments;

  static Call fromJson(Map<String, dynamic> json) {
    return _$CallFromJson(json);
  }

  Map toJson() {
    return _$CallToJson(this);
  }

  @override
  String toString() {
    return '';
//     return "$name(${arguments.join(",")})";
  }
}
