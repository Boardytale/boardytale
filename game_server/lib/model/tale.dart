part of game_server;

class ServerTale {
  static const colors = const ["#ff0000", "#0000ff", "#00ff00", "#00ffff"];
  LobbyRoom room;
  int _lastHeroId = 0;
  int lastUsedStartingField = 0;
  // TODO: split tale to assets and other data
  shared.InitialTaleData taleData;
  Map<String, shared.UnitType> unitTypes = {};
  Map<String, ServerUnit> units = {};
  int lastUnitId = 0;
  shared.AiGroup aiGroupOnMove = null;
  bool _humansOnMove = true;

  Iterable<shared.Player> get playersOnMove => _humansOnMove ? humanPlayers.values : aiPlayers.values;

  Iterable<String> get playersOnMoveIds => playersOnMove.map((p) => p.id);
  shared.World world;
  Map<String, ServerPlayer> players = {};
  Map<String, ServerPlayer> humanPlayers = {};
  Map<String, ServerPlayer> aiPlayers = {};
  int _lastAddedHumanPlayerIndex = 0;
  ServerTriggers triggers;
  ServerTaleEvents events;
  io.Socket currentAiPlayerSocket;

  ServerTale(this.room) {
    events = ServerTaleEvents(this);
    shared.Tale _tale = shared.Tale()..fromCompiledTale(room.compiledTale.tale);
    world = _tale.world;
    taleData = shared.InitialTaleData.fromCompiledTale(room.compiledTale.tale);
    room.connectedPlayers.values.forEach(addHumanPlayer);
    _tale.aiPlayers.forEach((key, player) {
      if (player.taleId == null) {
        player.taleId = player.id;
      }
      players[player.taleId] = ServerPlayer()..fromSharedPlayer(player);
      aiPlayers[player.taleId] = players[player.taleId];
    });
    taleData.players = players.values.map((p) => p.createGamePlayer()).toList();
    humanPlayers.values.forEach(sendTaleDataToPlayer);
    room.compiledTale.tale.unitTypes.forEach((String name, shared.UnitTypeCompiled unitType) {
      unitTypes[name] = shared.UnitType()..fromCompiledUnitType(unitType);
    });

    room.compiledTale.tale.units.forEach((shared.UnitCreateOrUpdateAction action) {
      if (action.unitId == null) {
        action.unitId = "${lastUnitId++}";
      }
      ServerUnit unit = ServerUnit(this, action, world.fields, players, unitTypes);
      units[unit.id] = unit;
    });

    Future.delayed(Duration(milliseconds: 10)).then((onValue) {
      sendInitialUnits(humanPlayers.values);
    });
    HeroesHelper.getHeroes(humanPlayers.values, humanPlayers.values, this);

    triggers = ServerTriggers(this, room.compiledTale.tale.triggers);
  }

  void sendInitTaleDataToPlayer(ServerPlayer player) {
    sendTaleDataToPlayer(player);
    sendInitialUnits([player]);
  }

  void sendTaleDataToPlayer(ServerPlayer player) {
    taleData.playerIdOnThisClientMachine = player.id;
    taleData.playerOnMoveIds = playersOnMoveIds.toList();
    gateway.sendMessage(shared.ToClientMessage.fromTaleData(taleData), player);
  }

  void handleUnitTrackAction(shared.UnitTrackAction action) {
    ServerUnit unit = units[action.unitId];
    shared.Track track = shared.Track(action.track.map((f) => world.fields[f]).toList());
    shared.AbilityName name = action.abilityName;
    unit.perform(name, track, action, this);
  }

  void sendInitialUnits(Iterable<ServerPlayer> players) {
    // TODO: implement line of sight here

    List<shared.UnitCreateOrUpdateAction> actions = [];
    units.forEach((id, unit) {
      actions.add(unit.getUnitCreateOrUpdateAction());
    });

    players.forEach((player) {
      gateway.sendMessage(shared.ToClientMessage.fromUnitCreateOrUpdate(actions, playersOnMoveIds), player);
    });
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
    if (taleData.humanPlayerIds.length > _lastAddedHumanPlayerIndex) {
      player.taleId = taleData.humanPlayerIds[_lastAddedHumanPlayerIndex];
    } else {
      player.taleId = player.id;
    }
    player.team = "players";
    players[player.id] = player;
    humanPlayers[player.id] = player;
    taleData.players = players.values.map((p) => p.createGamePlayer()).toList();
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
      taleData.units = units.values.map((ServerUnit unit) => unit.getUnitCreateOrUpdateAction()).toList();
      taleData.playerIdOnThisClientMachine = aiPlayers.values.first.id;
      taleData.playerOnMoveIds = [aiPlayers.values.first.id];
      socket.write(json.encode(
          shared.ToAiServerMessage.fromState(taleData, shared.AiEngine.standard, aiPlayers.values.first.id).toJson()));
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
      ..milliseconds = 3000
      ..text = "Victory";
    humanPlayers.values.forEach((player) {
      gateway.sendMessage(shared.ToClientMessage.fromBanter(banter), player);
    });
    Future.delayed(Duration(milliseconds: 3000)).then(endGame);
  }

  void lost() {
    shared.Banter banter = shared.Banter()
      ..image = null
      ..milliseconds = 3000
      ..text = "Lost";
    humanPlayers.values.forEach((player) {
      gateway.sendMessage(shared.ToClientMessage.fromBanter(banter), player);
    });
    Future.delayed(Duration(milliseconds: 3000)).then(endGame);
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
    taleData = null;
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
