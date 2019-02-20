part of game_server;

class ServerTale {
  static const colors = const [
    Color.Red,
    Color.Blue,
    Color.Green,
    Color.Yellow
  ];
  LobbyRoom room;

  Map<String, ServerPlayer> get players => room.connectedPlayers;
  shared.ClientTaleData taleData;
  shared.Tale sharedTale;
  Map<String, shared.UnitType> unitTypes = {};
  Map<String, ServerUnit> units = {};
  int _lastUnitId = 0;

  ServerTale(this.room) {
    int index = 0;
    sharedTale = shared.Tale()..fromCompiledTale(room.compiledTale.tale);
    taleData = shared.ClientTaleData.fromCompiledTale(room.compiledTale.tale);
    players.values.forEach((player) {
      player.color = ServerTale.colors[index++];
    });

    List<shared.Player> gamePlayers = [];
    players.values.forEach((player) {
      gamePlayers.add(player.createGamePlayer());
    });

    taleData.players = gamePlayers;

    players.values.forEach((player) {
      gateway.sendMessage(
          shared.ToClientMessage.fromTaleData(taleData), player);
    });

    Future.delayed(Duration(milliseconds: 10)).then((onValue) {
      sendInitialUnits();
    });
  }

  void sendInitTaleDataToPlayer(ServerPlayer player) {
    gateway.sendMessage(shared.ToClientMessage.fromTaleData(taleData), player);
  }

  void handlePlayerAction(MessageWithConnection message) {}

  void sendInitialUnits() {
    room.compiledTale.tale.assets.unitTypes
        .forEach((String name, shared.UnitTypeCompiled unitType) {
      unitTypes[name] = shared.UnitType()..fromCompiledUnitType(unitType);
    });

    // TODO: implement line of sight here
    room.compiledTale.tale.units.forEach((fieldId, unitName) {
      shared.UnitType unitType = unitTypes[unitName];
      String unitId = "${_lastUnitId++}";
      ServerUnit unit = ServerUnit()..fromUnitType(unitType);
      unit.field = sharedTale.world.fields[fieldId];
      units[unitId] = unit;
    });

    List<shared.UnitManipulateAction> actions = [];
    units.forEach((id, unit) {
      actions.add(shared.UnitManipulateAction()
        ..isCreate = true
        ..unitTypeName = unit.type.name
        ..fieldId = unit.field.id);
    });

    players.values.forEach((player) {
      gateway.sendMessage(
          shared.ToClientMessage.fromTaleStateUpdate(actions), player);
    });
  }
}
