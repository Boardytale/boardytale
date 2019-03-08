part of model;

@JsonSerializable()
class ClientTaleData {
  String name;
  Map<Lang, Map<String, String>> langs;
  Map<Lang, String> langName;
  WorldCreateEnvelope world;
  TaleCompiledAssets assets;
  List<Player> players;
  String playerIdOnThisClientMachine;
  Map<String, AiGroup> aiGroups = {};
  List<String> playerOnMoveIds;
  String aiGroupOnMove;

  ClientTaleData();

  ClientTaleData.fromCompiledTale(TaleInnerCompiled compiled){
    name = compiled.name;
    langs = compiled.langs;
    langName = compiled.langName;
    world = compiled.world;
    assets = compiled.assets;
    aiGroups = compiled.aiGroups;
  }

  static ClientTaleData fromJson(Map json) {
    utils.retypeMapInJsonToStringDynamic(json, ["langs", "langName"]);
    return _$ClientTaleDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClientTaleDataToJson(this);
  }
}
