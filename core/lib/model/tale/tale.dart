part of model;

@JsonSerializable()
class Tale {
  String name;
  Map<Lang, Map<String, String>> langs;
  Map<Lang, String> langName;
  World world;
  Map<String, UnitType> unitTypes = {};
  Map<String, Player> players = {};
  List<String> playerOnMoveIds;
  List<UnitCreateOrUpdateAction> units = [];

  Iterable<Player> get aiPlayers => players.values.where((p) => p.isAiPlayer);

  Tale();

  Tale.fromCompiledTale(TaleInnerCompiled compiled) {
    name = compiled.name;
    langs = compiled.langs;
    langName = compiled.langName;
    world = compiled.world;
  }

  static Tale fromJson(Map json) {
    utils.retypeMapInJsonToStringDynamic(json, ["langs", "langName"]);
    return _$TaleFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TaleToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class Assets {
  Map<String, Image> images = {};

  static Assets fromJson(Map json) {
    return _$AssetsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AssetsToJson(this);
  }

  void merge(Assets newAssets) {
    images.addAll(newAssets.images);
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

