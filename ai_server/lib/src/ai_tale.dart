part of ai_server;

class AiTale {
  final Connection connection;
  core.GetNextMoveByState initialRequest;
  core.Tale initialTaleData;
  core.AiEngine engine;
  Map<String, core.Player> players = {};

  // TODO: AI does not need images
  Map<String, core.UnitType> unitTypes = {};
  core.Player me;
  Set<core.Unit> playedUnits = Set<core.Unit>();
  covariant Map<String, core.Player> aiPlayers = {};
  Map<String, core.Field> fields;
  Map<String, core.Event> events = {};
  Map<String, core.Dialog> dialogs = {};
  Map<String, core.Unit> units = {};

  AiTale(this.initialRequest, this.connection) {
    initialTaleData = initialRequest.requestData;
    engine = initialRequest.requestEngine;
    unitTypes = initialTaleData.unitTypes;
    initialTaleData.players.forEach((key, player) {
      players[player.id] = player;
    });
    fields = core.World.createFields(initialTaleData.world, (key) => core.Field(key));
    initialTaleData.units.forEach((action) {
      units[action.unitId] = core.Unit(createAbilityList, action, fields, players, unitTypes);
    });
    me = players[initialRequest.idOfAiPlayerOnMove];
  }

  void nextMove() {
    core.Unit unitOnMove = getFirstPlayCapableUnitOfMine();
    if (unitOnMove == null) {
      endAiTurn();
      return;
    }
    print("starting next move with unit ${unitOnMove.id}");
    List<core.Unit> enemies = [];
    List<core.Unit> allies = [];
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

    core.SimpleLogger logger = core.SimpleLogger();
    core.Track track = core.Track(
        core.MapUtils.getNearestEnemyByTerrain(units, unitOnMove, fields, unitOnMove.steps, sight: 10, logger: logger));
    try {
      io.Directory("lib/log/").createSync(recursive: true);
      io.File("lib/log/lastNearestEnemy")
        ..createSync()
        ..writeAsString(logger.log);
    } catch (e) {
      print("cannot create log file for ai server");
    }
    if (track == null || track.fields == null || track.fields.isEmpty) {
      playedUnits.add(unitOnMove);
      nextMove();
      return;
    }
    int terrainLength = track.getMoveCostOfFreeWay();
    core.UnitTrackAction action = core.UnitTrackAction()..unitId = unitOnMove.id;
    if (terrainLength > unitOnMove.steps) {
      action.abilityName = core.AbilityName.move;
      action.track = track.subTrack(0, track.getEndIndexWithSteps(unitOnMove.steps) + 1).toIds();
    } else {
      action.abilityName = core.AbilityName.attack;
      action.track = track.toIds();
    }
    playedUnits.add(unitOnMove);
    gateway.sendMessage(core.ToGameServerMessage.unitTrackAction(action), connection);
  }

  core.Unit getFirstPlayCapableUnitOfMine() {
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
    gateway.sendMessage(core.ToGameServerMessage.controlsAction(core.ControlsActionName.endOfTurn), connection);
  }

  void applyPatch(core.GetNextMoveByUpdate update) {
    update.requestUpdateData.actions.forEach((action) {
      units[action.unitId]
          .addUnitUpdateAction(action, action.moveToFieldId != null ? fields[action.moveToFieldId] : null);
    });
  }
}

List<core.Ability> createAbilityList(core.AbilitiesEnvelope envelope) {
  List<core.Ability> out = [];
  if (envelope.move != null) {
    out.add(core.MoveAbility()..fromEnvelope(envelope.move));
  }
  if (envelope.attack != null) {
    out.add(core.AttackAbility()..fromEnvelope(envelope.attack));
  }
  return out;
}
