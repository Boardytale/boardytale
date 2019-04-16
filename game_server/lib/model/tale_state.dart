part of game_server;

class ServerTaleState {
  final ServerTale tale;
  core.TaleInnerCompiled compiled;
  core.Assets assets = core.Assets();
  Map<String, core.Unit> units = {};
  Map<String, ServerPlayer> players = {};
  Map<String, ServerPlayer> humanPlayers = {};
  Map<String, ServerPlayer> aiPlayers = {};
  Map<String, core.UnitType> unitTypes = {};
  Map<String, core.Field> fields;
  List<String> playerOnMoveIds = [];
  bool gameStared = false;

  List<TaleAction> actionLog = [];

  ServerTaleState(this.compiled, this.tale) {
    compiled.unitTypes.forEach((String name, core.UnitTypeCompiled unitType) {
      unitTypes[name] = core.UnitType()..fromCompiled(unitType, assets);
    });
    fields = core.World.createFields(compiled.world, (key) => core.Field(key));
  }

  core.Tale createTaleForPlayer(ServerPlayer player) {
    return core.Tale.fromCompiledTale(compiled)
      ..units = units.values.map((unit) => unit.getUnitCreateOrUpdateAction()).toList()
      ..unitTypes = unitTypes
      ..playerOnMoveIds = playerOnMoveIds
      ..players = players.map((key, player) => MapEntry(key, player.createGamePlayer()));
  }

  void addTaleAction(TaleAction action) {
    if (action == null) {
      // invalid unit track actions handled another way
      return;
    }
    actionLog.add(action);
    core.TaleUpdate outputTaleUpdate = core.TaleUpdate();
    action.newPlayersToTale.forEach((player) {
      players[player.id] = player;
      if (player.aiGroup != null) {
        aiPlayers[player.id] = player;
      } else {
        humanPlayers[player.id] = player;
      }
    });
    outputTaleUpdate.newPlayersToTale = action.newPlayersToTale.map((player) => player.createGamePlayer()).toList();
    if (action.playersOnMove != null) {
      playerOnMoveIds = action.playersOnMove;
    }

    action.newUnitTypesToTale.forEach((core.UnitType type) {
      unitTypes[type.name] = type;
    });
    outputTaleUpdate.newUnitTypesToTale = action.newUnitTypesToTale;

    if(action.newAssetsToTale != null){
      assets.merge(action.newAssetsToTale);
      outputTaleUpdate.newAssetsToTale = action.newAssetsToTale;
    }

    if (action.unitUpdates != null) {
      action.unitUpdates.forEach((core.UnitCreateOrUpdateAction action) {
        if (units.containsKey(action.unitId)) {
          core.Unit unit = units[action.unitId];
          unit.addUnitUpdateAction(action, fields[action.moveToFieldId]);
        } else {
          core.Unit unit = core.Unit(createServerAbilityList, action, fields, players, unitTypes);
          units[unit.id] = unit;
        }
      });
      outputTaleUpdate.actions = action.unitUpdates;
    }

    outputTaleUpdate.playerOnMoveIds = playerOnMoveIds;

    humanPlayers.forEach((key, player) {
      gateway.sendMessage(core.ToClientMessage.fromUnitCreateOrUpdate(outputTaleUpdate), player);
    });

    if (tale.currentAiPlayerSocket != null) {
      tale.currentAiPlayerSocket
          .add(json.encode(core.ToAiServerMessage.fromUpdate(outputTaleUpdate).toJson()));
    }
  }
}
