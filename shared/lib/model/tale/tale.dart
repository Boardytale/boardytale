part of model;

class Tale {
  String name;
  Map<Lang, Map<String, String>> langs;
  Map<Lang, String> langName;
  int humanPlayersTeam;
  covariant World world;
  covariant Map<String, Player> players = {};
  Map<String, AiGroup> aiGroups = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  Map<String, Unit> units = {};

  void fromCompiledTale(TaleInnerCompiled tale) {
    name = tale.name;
    langs = tale.langs;
    world = World()
      ..fromEnvelope(tale.world, (key, world) => Field(key, world));
    events = tale.events;
    dialogs = tale.dialogs;
    aiGroups = tale.aiGroups;
  }
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
