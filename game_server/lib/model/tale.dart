part of game_server;

class ServerTale {
  static const colors = const ["#ff0000", "#0000ff", "#00ff00", "#00ffff"];
  LobbyRoom room;
  int _lastHeroId = 0;
  int lastUsedStartingField = 0;
  shared.Tale taleState;
  Map<String, shared.UnitType> unitTypes = {};
  Map<String, ServerUnit> units = {};
  int lastUnitId = 0;
  shared.AiGroup aiGroupOnMove = null;
  bool _humansOnMove = true;
  Map<String, ServerPlayer> players = {};
  Map<String, ServerPlayer> humanPlayers = {};
  Map<String, ServerPlayer> aiPlayers = {};
  int _lastAddedHumanPlayerIndex = 0;
  ServerTriggers triggers;
  ServerTaleEvents events;
  io.Socket currentAiPlayerSocket;
  shared.Assets assets = shared.Assets();
  Map<String, shared.Field> fields;
  List<String> startingFieldIds;
  Iterable<shared.Player> get playersOnMove => _humansOnMove ? humanPlayers.values : aiPlayers.values;

  List<String> get playersOnMoveIds => playersOnMove.map((p) => p.id).toList();

  ServerTale(this.room) {
    events = ServerTaleEvents(this);
    startingFieldIds = room.compiledTale.tale.world.startingFieldIds;
    fields = shared.World.createFields(room.compiledTale.tale.world, (key) => shared.Field(key));
    taleState = shared.Tale.fromCompiledTale(room.compiledTale.tale, assets);
    room.compiledTale.tale.unitTypes.forEach((String name, shared.UnitTypeCompiled unitType) {
      unitTypes[name] = shared.UnitType()..fromCompiled(unitType, assets);
    });
    room.connectedPlayers.values.forEach(addHumanPlayer);
    room.compiledTale.tale.aiPlayers.forEach((key, player) {
      if (player.taleId == null) {
        player.taleId = player.id;
      }
      ServerPlayer newAiPlayer = ServerPlayer()..fromSharedPlayer(player);
      players[player.taleId] = newAiPlayer;
      aiPlayers[player.taleId] = players[player.taleId];
      taleState.addTaleAction(shared.TaleAction()..newPlayerToTale = newAiPlayer.createGamePlayer());
    });
    taleState.addTaleAction(shared.TaleAction()..playersOnMove = playersOnMoveIds);

    List<shared.UnitCreateOrUpdateAction> actions = [];
    room.compiledTale.tale.units.forEach((shared.UnitCreateOrUpdateAction action) {
      if (action.unitId == null) {
        action.unitId = "${lastUnitId++}";
      }
      ServerUnit unit = ServerUnit(this, action, fields, players, unitTypes);
      units[unit.id] = unit;
      actions.add(unit.getUnitCreateOrUpdateAction());
    });

    taleState.addTaleAction(shared.TaleAction()..newUnitsToTale=actions);

    humanPlayers.values.forEach(sendTaleDataToPlayer);
    HeroesHelper.getHeroes(humanPlayers.values, humanPlayers.values, this);
    triggers = ServerTriggers(this, room.compiledTale.tale.triggers);
  }

  void sendTaleDataToPlayer(ServerPlayer player) {
    taleState.playerOnMoveIds = playersOnMoveIds.toList();
    gateway.sendMessage(shared.ToClientMessage.fromTaleData(taleState, assets, player.id), player);
  }

  void handleUnitTrackAction(shared.UnitTrackAction action) {
    ServerUnit unit = units[action.unitId];
    shared.Track track = shared.Track(action.track.map((f) => fields[f]).toList());
    shared.AbilityName name = action.abilityName;
    unit.perform(name, track, action, this);
  }

  void sendNewState(shared.UnitCreateOrUpdateAction action) {
    humanPlayers.values.forEach((player) {
      gateway.sendMessage(shared.ToClientMessage.fromUnitCreateOrUpdate([action], playersOnMoveIds), player);
    });
    if (currentAiPlayerSocket != null) {
      currentAiPlayerSocket.write(
          json.encode(shared.ToAiServerMessage.fromUpdate(shared.UnitCreateOrUpdate()..actions = [action]).toJson()));
    }
  }

  void endOfTurn(MessageWithConnection message) {
    _humansOnMove = false;
    List<shared.UnitCreateOrUpdateAction> actions = [];
    units.forEach((key, unit) {
      if (unit.newTurn()) {
        actions.add(shared.UnitCreateOrUpdateAction()
          ..fromUnit(unit)
          ..unitId = unit.id);
      }
    });
    aiPlay();
    humanPlayers.values.forEach((player) {
      gateway.sendMessage(shared.ToClientMessage.fromUnitCreateOrUpdate(actions, playersOnMoveIds), player);
    });
  }

  void addHumanPlayer(ServerPlayer player) {
    player.color = ServerTale.colors[_lastAddedHumanPlayerIndex];
    if (taleState.humanPlayerIds.length > _lastAddedHumanPlayerIndex) {
      player.taleId = taleState.humanPlayerIds[_lastAddedHumanPlayerIndex];
    } else {
      player.taleId = player.id;
    }
    player.team = "players";
    players[player.id] = player;
    humanPlayers[player.id] = player;
    taleState.addTaleAction(shared.TaleAction()..newPlayerToTale = player.createGamePlayer());
    _lastAddedHumanPlayerIndex++;
  }

  void sendPlayersOnMove() {
    humanPlayers.values.forEach((player) {
      gateway.sendMessage(shared.ToClientMessage.fromUnitCreateOrUpdate([], playersOnMoveIds), player);
    });
  }

  void aiPlay() {
    //TODO: more ai players
    io.Socket.connect("localhost", config.aiServer.uris.first.port).then((io.Socket socket) {
      currentAiPlayerSocket = socket;
      taleState.units = units.values.map((ServerUnit unit) => unit.getUnitCreateOrUpdateAction()).toList();
      taleState.playerOnMoveIds = [aiPlayers.values.first.id];
      socket.write(json.encode(
          shared.ToAiServerMessage.fromState(taleState, shared.AiEngine.standard, aiPlayers.values.first.id).toJson()));
      socket.listen((List<int> aiServerData) {
        shared.ToGameServerMessage message =
            shared.ToGameServerMessage.fromJson(json.decode(String.fromCharCodes(aiServerData).trim()));
        if (message.message == shared.OnServerAction.controlsAction) {
          if (message.controlsActionMessage.actionName == shared.ControlsActionName.endOfTurn) {
            socket.close();
            socket.destroy();
            currentAiPlayerSocket = null;
            _humansOnMove = true;
            // TODO: refresh only units currently beginning their move
            sendPlayersOnMove();
          }
        } else if (message.message == shared.OnServerAction.unitTrackAction) {
          handleUnitTrackAction(message.unitTrackActionMessage);
        }
      });
    });
  }

  void victory() {
    shared.Banter banter = shared.Banter()
      ..image = null
      ..milliseconds = 10000
      ..text = "Victory";
    humanPlayers.values.forEach((player) {
      gateway.sendMessage(shared.ToClientMessage.fromBanter(banter), player);
    });
    Future.delayed(Duration(milliseconds: 10000)).then(endGame);
  }

  void lost() {
    shared.Banter banter = shared.Banter()
      ..image = null
      ..milliseconds = 10000
      ..text = "Lost";
    humanPlayers.values.forEach((player) {
      gateway.sendMessage(shared.ToClientMessage.fromBanter(banter), player);
    });
    Future.delayed(Duration(milliseconds: 10000)).then(endGame);
  }

  void endGame([_]) {
    humanPlayers.values.forEach((player) {
      player.leaveGame();
    });
    destroy();
  }

  void destroy() {
    units = null;
    unitTypes = null;
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
