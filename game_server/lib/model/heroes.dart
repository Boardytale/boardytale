part of game_server;

class HeroesHelper {
  static int _lastHeroId = 0;

  static Future getHeroes(
      Iterable<ServerPlayer> forPlayer, Iterable<ServerPlayer> emitToPlayers, ServerTale tale) async {
    List<Future<ResponseWithPlayer>> responses = [];
    forPlayer.forEach((player) {
      var url = "http://localhost:${config.userServer.innerPort}/";
      var message = core.ToUserServerMessage.fromPlayerEmail(player.email);
      responses.add(http.post(url, body: json.encode(message.toJson())).asStream().map((convert) {
        return ResponseWithPlayer(convert, player);
      }).first);
    });
    List<ResponseWithPlayer> data = await Future.wait(responses);
    List<core.UnitCreateOrUpdateAction> actions = [];
    List<core.UnitType> types = [];
    core.Assets assets = core.Assets();
    Set<String> fieldsOccupied = {};
    data.forEach((ResponseWithPlayer item) {
      var heroesAndUnits = core.ToUserServerMessage.fromJson(json.decode(item.response.body));
      heroesAndUnits.getHeroesOfPlayerMessage.responseHeroes.forEach((heroEnvelope) {
        var compiledType = heroEnvelope.type;
        compiledType.name = "hero${_lastHeroId++}";
        core.UnitType type = core.UnitType()..fromCompiled(compiledType, assets);
        var startingField = tale.getFirstFreeStartingField(fieldsOccupied);
        if(startingField == null){
          return;
        }

        core.UnitCreateOrUpdateAction action = core.UnitCreateOrUpdateAction()
          ..unitId = "${tale.lastUnitId++}"
          ..moveToFieldId = startingField.id
          ..transferToPlayerId = item.player.id
          ..changeToTypeName = type.name;
        types.add(type);
        actions.add(action);
      });

      heroesAndUnits.getHeroesOfPlayerMessage.responseUnits.forEach((core.UnitTypeCompiled compiledType) {
        core.UnitType type = core.UnitType()..fromCompiled(compiledType, assets);
        var startingField = tale.getFirstFreeStartingField(fieldsOccupied);
        if(startingField == null){
          return;
        }
        core.UnitCreateOrUpdateAction action = core.UnitCreateOrUpdateAction()
          ..unitId = "${tale.lastUnitId++}"
          ..moveToFieldId = startingField.id
          ..transferToPlayerId = item.player.id
          ..changeToTypeName = type.name;
        types.add(type);
        actions.add(action);
      });
    });
    tale.taleState.addTaleAction(TaleAction()
      ..unitUpdates = actions
      ..newUnitTypesToTale = types
      ..newAssetsToTale = assets);
  }
}
