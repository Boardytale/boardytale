part of deskovka_client;

class Game {
  int gold;
  ClientWorld world;
  List<ClientPlayer> players = [];
  ClientPlayer _playerOnMove;

  ClientPlayer get playerOnMove => _playerOnMove;

  set playerOnMove(ClientPlayer value) {
    _playerOnMove = value;
    callAll(playerOnMoveChanged);
  }

  List<Unit> units = [];
  Stream<Unit> onUnitCreated;
  StreamController<Unit> _onUnitCreated = new StreamController<Unit>();
  Stream<Unit> onUnitRemoved;
  StreamController<Unit> _onUnitRemoved = new StreamController<Unit>();
  PhaserWidget phaser;
  List onNewTurn = [];
  List playerOnMoveChanged = [];

  ClientPlayer get you {
    for (ClientPlayer p in players) {
      if (p.you) return p;
    }
    return null;
  }

  Game();

  void init() {
    players.add(new ClientPlayer("new")..you = true);
    onUnitCreated = _onUnitCreated.stream.asBroadcastStream();
    onUnitRemoved = _onUnitRemoved.stream.asBroadcastStream();
  }

  void start() {
    phaser = new PhaserWidget();
    world.adapters.add(new GameMapAdapter());
  }

  void trackStart() {}

  void fromJson(Map json) {
    gold = json["gold"];
    if (world == null) {
      world = new ClientWorld(7);
    }
    world.id = json["worldId"];
    List pls = json["players"];
    players.clear();
    for (Map p in pls) {
      addPlayer(new ClientPlayer(json["id"])..fromJson(p));
    }
    if (json.containsKey("playerOnMove") && json["playerOnMove"] != null) {
      playerOnMove = getPlayerById(json["playerOnMove"]);
    } else {
      playerOnMove = players.first;
    }

    List units = json["units"];
    if (units == null) {
      units = [];
    }
    updateUnits(units);
  }

  void addPlayer(ClientPlayer clientPlayer) {
    if (getPlayerById(clientPlayer.id) == null) {
      players.add(clientPlayer);
    } else {
      throw new Exception("attempt to add existing player to game");
    }
  }

  ClientPlayer getPlayerById(String id) {
    for (var p in players) {
      if (p.id == id) return p;
    }
    return null;
  }

  Unit createUnit(UnitType type, PlayerBase player, Field field) {
    Unit newUnit = new Unit(null, type, player, field);
    ;
    units.add(newUnit);
    _onUnitCreated.add(newUnit);
    return newUnit;
  }

  void updateUnits(List units) {
    clearUnits();
    for (Map u in units) {
      Unit unit = createUnit(unitTypes[u["type"]], getPlayerById(u["player"]),
          world.getField(u["field"]["x"], u["field"]["y"]));
      unit.id = u["id"];
    }
  }

  void clearUnits() {
    for (var u in units.toList()) {
      removeUnit(u);
    }
  }

  void removeUnit(Unit unit) {
    unit.field.units.remove(unit);
    units.remove(unit);
    _onUnitRemoved.add(unit);
  }

  void newTurn([Map data]) {
    if (data == null) {
      gf.send(ACTION_NEXT_TURN, {});
    } else {
      playerOnMove = getPlayerById(data["playerOnMove"]);
      for (Unit u in units) {
        u.newTurn();
      }
    }
    callAll(onNewTurn);
  }
}
