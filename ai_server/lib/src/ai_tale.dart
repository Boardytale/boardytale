part of ai_server;

class AiTale {
  final Connection connection;
  shared.GetNextMoveByState initialRequest;
  shared.Tale initialTaleData;
  shared.AiEngine engine;
  Map<String, shared.Player> players = {};

  // TODO: AI does not need images
  Map<String, shared.UnitType> unitTypes = {};
  shared.Player me;
  Set<shared.Unit> playedUnits = {};
  covariant Map<String, shared.Player> aiPlayers = {};
  Map<String, shared.Field> fields;
  Map<String, shared.Event> events = {};
  Map<String, shared.Dialog> dialogs = {};
  Map<String, shared.Unit> units = {};

  AiTale(this.initialRequest, this.connection) {
    initialTaleData = initialRequest.requestData;
    engine = initialRequest.requestEngine;
    unitTypes = initialTaleData.unitTypes;
    initialTaleData.players.forEach((key, player) {
      players[player.id] = player;
    });
    shared.World.createFields(initialTaleData.world, (key) => shared.Field(key));
    initialTaleData.units.forEach((action) {
      units[action.unitId] = shared.Unit(createAbilityList, action, fields, players, unitTypes);
    });
    me = players[initialRequest.idOfAiPlayerOnMove];
  }

  void nextMove() {
    shared.Unit unitOnMove = getFirstPlayCapableUnitOfMine();
    if (unitOnMove == null) {
      endAiTurn();
      return;
    }
    print("starting next move with unit ${unitOnMove.id}");
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

    shared.SimpleLogger logger = shared.SimpleLogger();
    shared.Track track =
        shared.Track(shared.MapUtils.getNearestEnemyByTerrain(units, unitOnMove, fields, unitOnMove.steps, logger: logger));
    io.File("lib/log/lastNearestEnemy")..createSync()..writeAsString(logger.log);
    int terrainLength = track.getMoveCostOfFreeWay();
    shared.UnitTrackAction action = shared.UnitTrackAction()..unitId = unitOnMove.id;
    if (terrainLength > unitOnMove.steps) {
      action.abilityName = shared.AbilityName.move;
      action.track = track.subTrack(0, track.getEndIndexWithSteps(unitOnMove.steps) + 1).toIds();
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
      if (unit.player.id == initialRequest.idOfAiPlayerOnMove &&
          unit.actions > 0 &&
          !playedUnits.contains(unit) &&
          unit.isAlive) {
        return unit;
      }
    }
    return null;
  }

  void endAiTurn() {
    gateway.sendMessage(shared.ToGameServerMessage.controlsAction(shared.ControlsActionName.endOfTurn), connection);
  }

  void applyPatch(shared.GetNextMoveByUpdate update) {
    update.requestUpdateData.actions.forEach((action) {
      units[action.unitId]
          .addUnitUpdateAction(action, action.moveToFieldId != null ? fields[action.moveToFieldId] : null);
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
