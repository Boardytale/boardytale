part of model;

@JsonSerializable()
class InitialTaleData {
  String name;
  Map<Lang, Map<String, String>> langs;
  Map<Lang, String> langName;
  WorldCreateEnvelope world;
  Map<String, Image> images = {};
  Map<String, UnitTypeCompiled> unitTypes = {};
  List<Player> players;
  String playerIdOnThisClientMachine;
  List<String> playerOnMoveIds;
  List<String> humanPlayerIds = [];
  List<UnitCreateOrUpdateAction> units;

  Iterable<Player> get aiPlayers => players.where((p) => p.isAiPlayer);

  InitialTaleData();

  InitialTaleData.fromCompiledTale(TaleInnerCompiled compiled) {
    name = compiled.name;
    langs = compiled.langs;
    langName = compiled.langName;
    world = compiled.world;
    unitTypes = compiled.unitTypes;
    images = compiled.images;
    humanPlayerIds = compiled.humanPlayerIds;
  }

  static InitialTaleData fromJson(Map json) {
    utils.retypeMapInJsonToStringDynamic(json, ["langs", "langName"]);
    return _$InitialTaleDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InitialTaleDataToJson(this);
  }
}
