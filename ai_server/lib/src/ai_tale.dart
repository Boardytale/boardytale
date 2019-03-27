part of ai_server;

class AiTale extends shared.Tale{
  shared.GetNextMoveByState initialRequest;
  shared.ClientTaleData clientTaleData;
  shared.AiEngine engine;
  Map<String, shared.Player> players;
  // TODO: AI does not need images
  Map<String, shared.UnitType> unitTypes;
  shared.Player playerOnMove;
  Map<String, shared.Unit> unit = {};
  AiTale(this.initialRequest){
    clientTaleData = initialRequest.requestData;
    engine = initialRequest.requestEngine;
    clientTaleData.assets.unitTypes.forEach((String name, shared.UnitTypeCompiled unitType) {
      unitTypes[name] = shared.UnitType()..fromCompiledUnitType(unitType);
    });
    clientTaleData.players.forEach((player){
      players[player.id] = player;
    });

    world = shared.World()
      ..fromEnvelope(clientTaleData.world, (key, world) => shared.Field(key, world));
    initialRequest.units.forEach((action){
      units[action.unitId] = shared.Unit(createAbilityList, action, world.fields, players, unitTypes);
    });
  }
}


List<shared.Ability> createAbilityList(shared.AbilitiesEnvelope envelope) {
  List<shared.Ability> out = [];
  if (envelope.move != null) {
    out.add(shared.MoveAbility()..fromEnvelope(envelope.move));
  }
  if (envelope.attack != null) {
    out.add(shared.AttackAbility()..fromEnvelope(envelope.attack));
  }
  return out;
}


