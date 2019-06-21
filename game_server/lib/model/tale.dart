part of game_server;

class ServerTale {
  static const colors = const ["#ff0000", "#0000ff", "#00ff00", "#00ffff"];
  LobbyRoom room;
  int _lastHeroId = 0;
  int lastUsedStartingField = 0;
  int lastUnitId = 0;
  ServerTaleState taleState;
  core.AiGroup aiGroupOnMove = null;
  int _lastIndexOfPlayerGotPlayersUnit = 0;
  ServerTriggers triggers;
  ServerTaleEvents events;
  io.WebSocket currentAiPlayerSocket;
  int _messagesOverflowProtection = 0;

  List<ServerPlayer> get humanPlayers {
    return taleState.humanPlayers.values.toList();
  }

  ServerTale(this.room) {
    events = ServerTaleEvents(this);
    triggers = ServerTriggers(this, room.compiledTale.tale.triggers);
    taleState = ServerTaleState(room.compiledTale.tale, this);

    for (var player in room.connectedPlayers.values) {
      taleState.addTaleAction(TaleAction()..newPlayersToTale = [upgradeConnectedHumanPlayerToTalePlayer(player)]);
    }

    List<ServerPlayer> aiPlayers = room.compiledTale.tale.aiPlayers.values.map((player) {
      player.taleId = player.taleId ?? player.id;
      return ServerPlayer()..fromCorePlayer(player);
    }).toList();
    List<core.UnitCreateOrUpdateAction> actions =
        room.compiledTale.tale.units.map((action) => upgradeInitUnitAction(action, humanPlayers)).toList();

    taleState.addTaleAction(TaleAction()
      ..newPlayersToTale = [...aiPlayers]
      ..unitUpdates = actions
      ..playersOnMove = room.compiledTale.tale.humanPlayerIds);
    triggers.onInit();
    humanPlayers.forEach(sendTaleDataToPlayer);
    Logger.log(taleState.taleId, core.LoggerMessage.fromTaleData(taleState.createTaleForPlayer(null)));
    taleState.gameStared = true;
    triggers.onAfterInit();
    HeroesHelper.getHeroes(taleState.humanPlayers.values, taleState.humanPlayers.values, this);
  }

  void sendTaleDataToPlayer(ServerPlayer player) {
    gateway.sendMessage(
        core.ToClientMessage.fromTaleData(taleState.createTaleForPlayer(player), taleState.assets, player.id), player);
  }

  void handleUnitTrackAction(core.UnitTrackAction action, {io.WebSocket aiPlayerSocket}) {
    core.Unit unit = taleState.units[action.unitId];
    core.Track track = core.Track(action.track.map((f) => taleState.fields[f]).toList());
    core.AbilityName name = action.abilityName;
    taleState.addTaleAction(ServerUnit.perform(name, track, action, this, unit, unit.player as ServerPlayer,
        aiPlayerSocket: aiPlayerSocket));
  }

  void endOfTurn() {
    List<core.UnitCreateOrUpdateAction> actions = taleState.units.values.map((unit) {
      return ServerUnit.newTurn(unit);
    }).toList();
    taleState.addTaleAction(TaleAction()
      ..unitUpdates = actions
      ..playersOnMove = taleState.aiPlayers.keys.toList());
    aiPlay();
  }

  core.UnitCreateOrUpdateAction upgradeInitUnitAction(
      core.UnitCreateOrUpdateAction action, List<ServerPlayer> humanPlayers) {
    action.unitId = action.unitId ?? "${lastUnitId++}";
    if (action.transferToPlayerId == "players") {
      action.transferToPlayerId = humanPlayers[_lastIndexOfPlayerGotPlayersUnit].id;
      _lastIndexOfPlayerGotPlayersUnit++;
      if (_lastIndexOfPlayerGotPlayersUnit > humanPlayers.length - 1) {
        _lastIndexOfPlayerGotPlayersUnit = 0;
      }
    }
    return action;
  }

  String getFirstFreeTalePlayerId() {
    for (int i = 0; i < taleState.compiled.humanPlayerIds.length; i++) {
      String taleId = taleState.compiled.humanPlayerIds[i];
      bool anyPlayerHasThisId = humanPlayers.any((player) => player.taleId == taleId);
      if (!anyPlayerHasThisId) {
        return taleId;
      }
    }
    throw "No available taleId for player";
  }

  core.Field getFirstFreeStartingField(Set<String> fieldsOccupied) {
    for (int i = 0; i < taleState.compiled.world.startingFieldIds.length; i++) {
      String fieldId = taleState.compiled.world.startingFieldIds[i];
      core.Field field = taleState.fields[fieldId];
      if (field.units.isEmpty && !fieldsOccupied.contains(fieldId)) {
        fieldsOccupied.add(fieldId);
        return field;
      }
    }
    print("No available field for starting position");
    return null;
  }

  ServerPlayer upgradeConnectedHumanPlayerToTalePlayer(ServerPlayer player) {
    player.taleId = getFirstFreeTalePlayerId();
    player.color = ServerTale.colors[taleState.compiled.humanPlayerIds.indexOf(player.taleId)];
    player.team = "players";
    return player;
  }

  void newPlayerEntersTale(ServerPlayer player) {
    player.enterGame(room.tale);
    room.tale.taleState
        .addTaleAction(TaleAction()..newPlayersToTale = [room.tale.upgradeConnectedHumanPlayerToTalePlayer(player)]);
    room.tale.sendTaleDataToPlayer(player);
    HeroesHelper.getHeroes([player], room.connectedPlayers.values, room.tale);
  }

  void sendMessages(core.TaleUpdate outputTaleUpdate) {
    if (_messagesOverflowProtection++ > taleState.units.length * 3) {
      Logger.log(taleState.taleId, core.LoggerMessage.fromTrace("message overflow"));
      endOfTurn();
    }
    taleState.humanPlayers.forEach((key, player) {
      gateway.sendMessage(core.ToClientMessage.fromUnitCreateOrUpdate(outputTaleUpdate), player);
    });

    if (currentAiPlayerSocket != null) {
      currentAiPlayerSocket.add(json.encode(core.ToAiServerMessage.fromUpdate(outputTaleUpdate).toJson()));
    }
  }

  void aiPlay() async {
    //TODO: more ai players
    String uri = "ws://localhost:${config.aiServer.uris.first.port}/";
    Logger.log(taleState.taleId, core.LoggerMessage.fromTrace("opening connection to ai server $uri"));
    currentAiPlayerSocket = await io.WebSocket.connect(uri);
    Logger.log(taleState.taleId, core.LoggerMessage.fromTrace("opened connection to ai server $uri"));
    ServerPlayer player = taleState.aiPlayers.values.first;
    currentAiPlayerSocket.add(json.encode(
        core.ToAiServerMessage.fromState(taleState.createTaleForPlayer(player), core.AiEngine.standard, player.id)
            .toJson()));
    currentAiPlayerSocket.listen((dynamic aiServerData) {
      String messageString = aiServerData.toString();
      print(messageString);
      core.ToGameServerMessage message = core.ToGameServerMessage.fromJson(json.decode(messageString));
      if (message.message == core.OnServerAction.controlsAction) {
        if (message.controlsAction.actionName == core.ControlsActionName.endOfTurn) {
          currentAiPlayerSocket.close();
          currentAiPlayerSocket = null;
          _messagesOverflowProtection = 0;

          // TODO: refresh only units currently beginning their move
          taleState.addTaleAction(TaleAction()..playersOnMove = taleState.humanPlayers.keys.toList());
        }
      } else if (message.message == core.OnServerAction.unitTrackAction) {
        handleUnitTrackAction(message.unitTrackAction, aiPlayerSocket: currentAiPlayerSocket);
      }
    });
  }

  void victory() {
    core.ShowBanterAction banter = core.ShowBanterAction()
      ..image = null
      ..showTimeInMilliseconds = 10000
      ..title = {core.Lang.en: "Victory", core.Lang.cz: "Vítězství"};
    taleState.addTaleAction(TaleAction()..banterAction = banter);
    room.connectedPlayers.forEach((key, player) {
      core.HeroAfterGameGain gain = core.HeroAfterGameGain()
        ..heroId = player.usedHeroId
        ..itemTypeNames = player.currentGameGain
        ..money = 0
        ..xp = taleState.compiled.experienceForHeroes ~/ room.connectedPlayers.length;
      ;
      player.currentGameGain = [];
      gateway.innerMessageToUserServer(core.ToUserServerInnerMessage.createHeroAfterGameGain(gain));
    });
    Future.delayed(Duration(milliseconds: 10000)).then(endGame);
  }

  void lost() {
    core.ShowBanterAction banter = core.ShowBanterAction()
      ..image = null
      ..showTimeInMilliseconds = 10000
      ..title = {core.Lang.en: "Lost", core.Lang.cz: "Prohra"};
    taleState.addTaleAction(TaleAction()..banterAction = banter);
    Future.delayed(Duration(milliseconds: 10000)).then(endGame);
  }

  void endGame([_]) {
    taleState.humanPlayers.values.toList().forEach((player) {
      player.leaveGame();
    });
    destroy();
  }

  void destroy() {
    if (taleState != null) {
      taleState.units = null;
      taleState.unitTypes = null;
      taleState = null;
    }
    triggers = null;
    if (room != null) {
      room.destroy();
      room = null;
    }
  }

  void ejectPlayer(ServerPlayer player) {
    taleState.addTaleAction(TaleAction()..removePlayerId = player.id);
  }
}

class MessageWithPlayer {
  core.HeroesAndUnitsOfPlayer response;
  ServerPlayer player;

  MessageWithPlayer(this.response, this.player);
}
