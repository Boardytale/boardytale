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
    taleState = ServerTaleState(room.compiledTale.tale, this);
    room.connectedPlayers.values.forEach(addHumanPlayer);
    taleState.addTaleAction(TaleAction()
      ..newPlayersToTale = room.compiledTale.tale.aiPlayers.values.map((player) {
        if (player.taleId == null) {
          player.taleId = player.id;
        }
        return ServerPlayer()..fromCorePlayer(player);
      }).toList());
    taleState.addTaleAction(TaleAction()..playersOnMove = room.compiledTale.tale.humanPlayerIds);

    List<core.UnitCreateOrUpdateAction> actions = [];
    List<ServerPlayer> humanPlayers = taleState.humanPlayers.values.toList();
    room.compiledTale.tale.units.forEach((core.UnitCreateOrUpdateAction action) {
      if (action.unitId == null) {
        action.unitId = "${lastUnitId++}";
      }
      if(action.transferToPlayerId == "players"){
        action.transferToPlayerId = humanPlayers[_lastIndexOfPlayerGotPlayersUnit].id;
        _lastIndexOfPlayerGotPlayersUnit++;
        if(_lastIndexOfPlayerGotPlayersUnit > humanPlayers.length - 1){
          _lastIndexOfPlayerGotPlayersUnit = 0;
        }
      }
      actions.add(action);
    });
    taleState.addTaleAction(TaleAction()..unitUpdates = actions);

    triggers = ServerTriggers(this, room.compiledTale.tale.triggers);
    taleState.humanPlayers.values.forEach(sendTaleDataToPlayer);
    Logger.log(taleState.taleId, core.LoggerMessage.fromTaleData(taleState.createTaleForPlayer(null)));
    taleState.gameStared = true;
    HeroesHelper.getHeroes(taleState.humanPlayers.values, taleState.humanPlayers.values, this);
  }

  void sendTaleDataToPlayer(ServerPlayer player) {
    gateway.sendMessage(
        core.ToClientMessage.fromTaleData(taleState.createTaleForPlayer(player), taleState.assets, player.id), player);
  }

  void handleUnitTrackAction(core.UnitTrackAction action) {
    core.Unit unit = taleState.units[action.unitId];
    core.Track track = core.Track(action.track.map((f) => taleState.fields[f]).toList());
    core.AbilityName name = action.abilityName;
    taleState.addTaleAction(ServerUnit.perform(name, track, action, this, unit, unit.player as ServerPlayer));
  }

  void endOfTurn(MessageWithConnection message) {
    List<core.UnitCreateOrUpdateAction> actions = taleState.units.values.map((unit) {
      return ServerUnit.newTurn(unit);
    }).toList();
    taleState.addTaleAction(TaleAction()..unitUpdates = actions);
    aiPlay();
    sendPlayersOnMove();
  }

  void addHumanPlayer(ServerPlayer player) {
    player.color = ServerTale.colors[_lastAddedHumanPlayerIndex];
    if (room.compiledTale.tale.humanPlayerIds.length > _lastAddedHumanPlayerIndex) {
      player.taleId = room.compiledTale.tale.humanPlayerIds[_lastAddedHumanPlayerIndex];
    } else {
      player.taleId = player.id;
    }
    player.team = "players";
    taleState.addTaleAction(TaleAction()..newPlayersToTale = [player]);
    _lastAddedHumanPlayerIndex++;
  }

  void sendPlayersOnMove() {
    taleState.humanPlayers.values.forEach((player) {
      gateway.sendMessage(
          core.ToClientMessage.fromUnitCreateOrUpdate(core.TaleUpdate()..playerOnMoveIds = taleState.playerOnMoveIds),
          player);
    });
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
          sendPlayersOnMove();
        }
      } else if (message.message == core.OnServerAction.unitTrackAction) {
        handleUnitTrackAction(message.unitTrackActionMessage);
      }
    });
  }

  void victory() {
    core.ShowBanterAction banter = core.ShowBanterAction()
      ..image = null
      ..showTimeInMilliseconds = 10000
      ..title = {
        core.Lang.en: "Victory",
        core.Lang.cz: "Vítězství"
      };
    taleState.addTaleAction(TaleAction()..banterAction = banter);
    Future.delayed(Duration(milliseconds: 10000)).then(endGame);
  }

  void lost() {
    core.ShowBanterAction banter = core.ShowBanterAction()
      ..image = null
      ..showTimeInMilliseconds = 10000
      ..title = {
        core.Lang.en: "Lost",
        core.Lang.cz: "Prohra"
      };
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
    if(taleState != null){
      taleState.units = null;
      taleState.unitTypes = null;
      taleState = null;
    }
    triggers = null;
    if(room != null) {
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
