part of game_server;

class HeroesHelper {
  static int _lastHeroId = 0;

  static Future getHeroes(
      Iterable<ServerPlayer> forPlayer, Iterable<ServerPlayer> emitToPlayers, ServerTale tale) async {
    List<Future<MessageWithPlayer>> responses = [];
    forPlayer.forEach((player) {
      var message = core.ToUserServerInnerMessage.createGetStartingUnits(player.email, player.nextGameHeroId);
      responses.add(gateway.innerMessageToUserServer(message).asStream().map((core.ToUserServerInnerMessage convert) {
        core.HeroesAndUnitsOfPlayer units;
        try{
          units = convert.getStartingUnits;
        }catch(e){
          print("cannot deserialize starting units ${convert.content}");
        }
        return MessageWithPlayer(units, player);
      }).first);
    });
    List<MessageWithPlayer> data = await Future.wait(responses);
    List<core.UnitCreateOrUpdateAction> actions = [];
    List<core.UnitType> types = [];
    core.Assets assets = core.Assets();
    Set<String> fieldsOccupied = {};
    data.forEach((MessageWithPlayer item) {
      item.response.responseHeroes.forEach((heroEnvelope) {
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

        item.player.usedHero = heroEnvelope;
      });

      item.response.responseUnits.forEach((core.UnitTypeCompiled compiledType) {
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
