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
  List<String> humanPlayerIds = [];
  List<UnitCreateOrUpdateAction> units = [];

  Iterable<Player> get aiPlayers => players.values.where((p) => p.isAiPlayer);

  @JsonKey(ignore: true)
  List<TaleAction> actionLog = [];
  Tale();

  Tale.fromCompiledTale(TaleInnerCompiled compiled, Assets assets) {
    name = compiled.name;
    langs = compiled.langs;
    langName = compiled.langName;
    world = compiled.world;
    compiled.unitTypes.forEach((key, type){
      unitTypes[key] = UnitType()..fromCompiled(type, assets);
    });
    humanPlayerIds = compiled.humanPlayerIds;
  }

  static Tale fromJson(Map json) {
    utils.retypeMapInJsonToStringDynamic(json, ["langs", "langName"]);
    return _$TaleFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TaleToJson(this);
  }

  void addTaleAction(TaleAction action){
    actionLog.add(action);
    if(action.newPlayerToTale != null){
      players[action.newPlayerToTale.id] = action.newPlayerToTale;
    }
    if(action.playersOnMove != null){
      playerOnMoveIds = action.playersOnMove;
    }
    if(action.newUnitsToTale != null){
      units.addAll(action.newUnitsToTale);
    }
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

