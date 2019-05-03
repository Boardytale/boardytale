part of game_server;

class ServerTale {
  static const colors = const ["#ff0000", "#0000ff", "#00ff00", "#00ffff"];
  LobbyRoom room;
  int _lastHeroId = 0;
  int lastUsedStartingField = 0;
  int lastUnitId = 0;
  ServerTaleState taleState;
  core.AiGroup aiGroupOnMove = null;
  bool _humansOnMove = true;
  int _lastAddedHumanPlayerIndex = 0;
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
    room.compiledTale.tale.units.forEach((core.UnitCreateOrUpdateAction action) {
      if (action.unitId == null) {
        action.unitId = "${lastUnitId++}";
      }
      actions.add(action);
    });
    taleState.addTaleAction(TaleAction()..unitUpdates = actions);

    taleState.humanPlayers.values.forEach(sendTaleDataToPlayer);
    Logger.log(taleState.taleId, core.LoggerMessage.fromTaleData(taleState.createTaleForPlayer(null)));
    taleState.gameStared = true;
    HeroesHelper.getHeroes(taleState.humanPlayers.values, taleState.humanPlayers.values, this);
    triggers = ServerTriggers(this, room.compiledTale.tale.triggers);
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
    _humansOnMove = false;
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
          _humansOnMove = true;
          // TODO: refresh only units currently beginning their move
          sendPlayersOnMove();
        }
      } else if (message.message == core.OnServerAction.unitTrackAction) {
        handleUnitTrackAction(message.unitTrackActionMessage);
      }
    });
  }

  void victory() {
    core.Banter banter = core.Banter()
      ..image = null
      ..milliseconds = 10000
      ..text = "Victory";
    taleState.humanPlayers.values.forEach((player) {
      gateway.sendMessage(core.ToClientMessage.fromBanter(banter), player);
    });
    Future.delayed(Duration(milliseconds: 10000)).then(endGame);
  }

  void lost() {
    core.Banter banter = core.Banter()
      ..image = null
      ..milliseconds = 10000
      ..text = "Lost";
    taleState.humanPlayers.values.forEach((player) {
      gateway.sendMessage(core.ToClientMessage.fromBanter(banter), player);
    });
    Future.delayed(Duration(milliseconds: 10000)).then(endGame);
  }

  void endGame([_]) {
    taleState.humanPlayers.values.forEach((player) {
      player.leaveGame();
    });
    destroy();
  }

  void destroy() {
    taleState.units = null;
    taleState.unitTypes = null;
    taleState = null;
    triggers = null;
    room.destroy();
    room = null;
  }
}

class ResponseWithPlayer {
  http.Response response;
  ServerPlayer player;

  ResponseWithPlayer(this.response, this.player);
}
