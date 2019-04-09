part of game_server;

class HeroesHelper {
  static int _lastHeroId = 0;

  static Future getHeroes(
      Iterable<ServerPlayer> forPlayer, Iterable<ServerPlayer> emitToPlayers, ServerTale tale) async {
    List<Future<ResponseWithPlayer>> responses = [];
    forPlayer.forEach((player) {
      var url = "http://localhost:${config.heroesServer.uris.first.port}/";
      var message = shared.ToHeroServerMessage.fromPlayerEmail(player.email);
      responses.add(http.post(url, body: json.encode(message.toJson())).asStream().map((convert) {
        return ResponseWithPlayer(convert, player);
      }).first);
    });
    List<ResponseWithPlayer> data = await Future.wait(responses);
    List<shared.UnitCreateOrUpdateAction> actions = [];
    data.forEach((item) {
      var hero = shared.ToHeroServerMessage.fromJson(json.decode(item.response.body));
      var heroEnvelope = hero.getHeroesOfPlayerMessage.responseHeroes.first;
      var compiledType = heroEnvelope.type;
      compiledType.name = "hero${_lastHeroId++}";
      shared.Assets newAssets = shared.Assets();
      shared.UnitType type = shared.UnitType()..fromCompiled(compiledType, newAssets);
      tale.assets.merge(newAssets);
      tale.unitTypes[compiledType.name] = type;
      tale.taleState.unitTypes[compiledType.name] = type;

      var startingField = tale.fields[tale.startingFieldIds[tale.lastUsedStartingField++]];

      shared.UnitCreateOrUpdateAction action = shared.UnitCreateOrUpdateAction()
        ..unitId = "${tale.lastUnitId++}"
        ..moveToFieldId = startingField.id
        ..transferToPlayerId = item.player.id
        ..changeToTypeName = type.name
        ..newUnitTypeToTale = type
        ..newAssetsToTale = newAssets;

      ServerUnit unit = ServerUnit(tale, action, tale.fields, tale.players, tale.unitTypes);
      tale.units[unit.id] = unit;
      action.newPlayerToTale = item.player;
      action.isNewPlayerOnMove = tale.playersOnMoveIds.contains(item.player.id);
      actions.add(action);
    });
    tale.taleState.addTaleAction(shared.TaleAction()..newUnitsToTale = actions);
    emitToPlayers.forEach((player) {
      gateway.sendMessage(shared.ToClientMessage.fromUnitCreateOrUpdate(actions, tale.playersOnMoveIds), player);
    });
  }
}
