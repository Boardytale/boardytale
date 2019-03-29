part of ai_server;

class AiTale extends shared.Tale {
  final Connection connection;
  shared.GetNextMoveByState initialRequest;
  shared.InitialTaleData initialTaleData;
  shared.AiEngine engine;
  Map<String, shared.Player> players = {};

  // TODO: AI does not need images
  Map<String, shared.UnitType> unitTypes = {};
  shared.Player me;
  Set<shared.Unit> playedUnits = {};

  AiTale(this.initialRequest, this.connection) {
    initialTaleData = initialRequest.requestData;
    engine = initialRequest.requestEngine;
    initialTaleData.unitTypes.forEach((String name, shared.UnitTypeCompiled unitType) {
      unitTypes[name] = shared.UnitType()..fromCompiledUnitType(unitType);
    });
    initialTaleData.players.forEach((player) {
      players[player.id] = player;
    });
    world = shared.World()..fromEnvelope(initialTaleData.world, (key, world) => shared.Field(key, world));
    initialTaleData.units.forEach((action) {
      units[action.unitId] = shared.Unit(createAbilityList, action, world.fields, players, unitTypes);
    });
    me = players[initialRequest.idOfAiPlayerOnMove];
  }

  void nextMove() {
    shared.Unit unitOnMove = getFirstPlayCapableUnitOfMine();
    if(unitOnMove == null){
      endAiTurn();
      return;
    }
    List<shared.Unit> enemies = [];
    List<shared.Unit> allies = [];
    units.forEach((key, oneOfUnits) {
      if (oneOfUnits.player.team != unitOnMove.player.team) {
        enemies.add(oneOfUnits);
      } else {
        allies.add(oneOfUnits);
      }
    });
    if (enemies.isEmpty) {
      endAiTurn();
      return;
    }
    if (allies.every((unit) => playedUnits.contains(unit))) {
      endAiTurn();
      return;
    }
    shared.Track track = shared.Track(shared.MapUtils.getNearestEnemyByTerrain(units, unitOnMove, world.fields));
    int terrainLength = track.getMoveCostOfFreeWay();
    shared.UnitTrackAction action = shared.UnitTrackAction()..unitId = unitOnMove.id;
    if (terrainLength - 1 > unitOnMove.steps) {
      action.abilityName = shared.AbilityName.move;
      action.track = track.subTrack(0, track.getEndIndexWithSteps(unitOnMove.steps)).toIds();
    } else {
      action.abilityName = shared.AbilityName.attack;
      action.track = track.toIds();
    }
    gateway.sendMessage(shared.ToGameServerMessage.unitTrackAction(action), connection);
  }

  shared.Unit getFirstPlayCapableUnitOfMine() {
    var unitList = units.values.toList();
    for (var i = 0; i < unitList.length; i++) {
      var unit = unitList[i];
      if (unit.player.id == initialRequest.idOfAiPlayerOnMove && unit.actions > 0 && !playedUnits.contains(unit)) {
        return unit;
      }
    }
    return null;
  }

  void endAiTurn() {
    gateway.sendMessage(shared.ToGameServerMessage.controlsAction(shared.ControlsActionName.andOfTurn), connection);
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
