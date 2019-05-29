part of game_server;

class ServerTale {
  static const colors = const ["#ff0000", "#0000ff", "#00ff00", "#00ffff"];
  LobbyRoom room;
  int _lastHeroId = 0;
  int lastUsedStartingField = 0;
  int lastUnitId = 0;
  ServerTaleState taleState;
  core.AiGroup aiGroupOnMove = null;
  int _lastAddedHumanPlayerIndex = 0;
  int _lastIndexOfPlayerGotPlayersUnit = 0;
  ServerTriggers triggers;
  ServerTaleEvents events;
  io.WebSocket currentAiPlayerSocket;

  ServerTale(this.room) {
    events = ServerTaleEvents(this);
    triggers = ServerTriggers(this, room.compiledTale.tale.triggers);
    taleState = ServerTaleState(room.compiledTale.tale, this);

    List<ServerPlayer> humanPlayers =
        room.connectedPlayers.values.map(upgradeConnectedHumanPlayerToTalePlayer).toList();
    List<ServerPlayer> aiPlayers = room.compiledTale.tale.aiPlayers.values.map((player) {
      player.taleId = player.taleId ?? player.id;
      return ServerPlayer()..fromCorePlayer(player);
    }).toList();
    List<core.UnitCreateOrUpdateAction> actions =
        room.compiledTale.tale.units.map((action) => upgradeInitUnitAction(action, humanPlayers)).toList();

    taleState.addTaleAction(TaleAction()
      ..newPlayersToTale = [...humanPlayers, ...aiPlayers]
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
    taleState.addTaleAction(ServerUnit.perform(name, track, action, this, unit, unit.player as ServerPlayer, aiPlayerSocket: aiPlayerSocket));
  }

  void endOfTurn(MessageWithConnection message) {
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
      if(_lastIndexOfPlayerGotPlayersUnit > humanPlayers.length - 1){
        _lastIndexOfPlayerGotPlayersUnit = 0;
      }
    }
    return action;
  }

  ServerPlayer upgradeConnectedHumanPlayerToTalePlayer(ServerPlayer player) {
    player.color = ServerTale.colors[_lastAddedHumanPlayerIndex];
    if (room.compiledTale.tale.humanPlayerIds.length > _lastAddedHumanPlayerIndex) {
      player.taleId = room.compiledTale.tale.humanPlayerIds[_lastAddedHumanPlayerIndex];
    } else {
      player.taleId = player.id;
    }
    player.team = "players";
    _lastAddedHumanPlayerIndex++;
    return player;
  }

  void newPlayerEntersTale(ServerPlayer player){
    player.enterGame(room.tale);
    room.tale.taleState.addTaleAction(
        TaleAction()..newPlayersToTale = [room.tale.upgradeConnectedHumanPlayerToTalePlayer(player)]);
    room.tale.sendTaleDataToPlayer(player);
    HeroesHelper.getHeroes([player], room.connectedPlayers.values, room.tale);
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
        if (message.controlsActionMessage.actionName == core.ControlsActionName.endOfTurn) {
          currentAiPlayerSocket.close();
          currentAiPlayerSocket = null;

          // TODO: refresh only units currently beginning their move
          taleState.addTaleAction(TaleAction()..playersOnMove = taleState.humanPlayers.keys.toList());
        }
      } else if (message.message == core.OnServerAction.unitTrackAction) {
        handleUnitTrackAction(message.unitTrackActionMessage, aiPlayerSocket: currentAiPlayerSocket);
      }
    });
  }

  void victory() {
    core.ShowBanterAction banter = core.ShowBanterAction()
      ..image = null
      ..showTimeInMilliseconds = 10000
      ..title = {core.Lang.en: "Victory", core.Lang.cz: "Vítězství"};
    taleState.addTaleAction(TaleAction()..banterAction = banter);
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

class ResponseWithPlayer {
  http.Response response;
  ServerPlayer player;

  ResponseWithPlayer(this.response, this.player);
}
