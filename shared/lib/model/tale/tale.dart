part of model;

class Tale {
  String name;
  Map<Lang, Map<String, String>> langs;
  Map<Lang, String> langName;
  int humanPlayersTeam;
  covariant World clientWorldService;
  covariant Map<String, Player> aiPlayers = {};
  Map<String, Event> events = {};
  Map<String, Dialog> dialogs = {};
  Map<String, Unit> units = {};

  void fromCompiledTale(TaleInnerCompiled tale) {
    name = tale.name;
    langs = tale.langs;
    clientWorldService = World()
      ..fromEnvelope(tale.world, (key, world) => Field(key, world));
    events = tale.events;
    dialogs = tale.dialogs;
    tale.aiPlayers.forEach((key, ai){
      aiPlayers[key] = ai;
    });
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
class Dialog {
  String name;
  static Dialog fromJson(Map<String, dynamic> json) {
    return _$DialogFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DialogToJson(this);
  }
}

