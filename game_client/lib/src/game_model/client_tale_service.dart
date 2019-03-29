part of client_model;

@Injectable()
class ClientTaleService extends shared.Tale {
  final SettingsService settings;
  final AppService appService;
  final GatewayService gatewayService;
  final GameService gameService;
  Map<String, shared.UnitType> unitTypes = {};

  Map<String, ClientPlayer> get aiPlayers => appService.players;

  ClientTaleService(this.gatewayService, this.settings, this.appService, this.gameService) : super() {
    gameService.clientTaleData.listen(handleTaleData);
  }

  void handleTaleData(shared.InitialTaleData clientTaleData) {
    name = clientTaleData.name;
    langName = clientTaleData.langName;
    clientTaleData.players.forEach((player) {
      if (appService.players.containsKey(player.id)) {
        appService.players[player.id].fromSharedPlayer(player);
      } else {
        appService.players[player.id] = ClientPlayer()..fromSharedPlayer(player);
      }
    });
    clientTaleData.unitTypes.forEach((String name, shared.UnitTypeCompiled unitType) {
      unitTypes[name] = shared.UnitType()..fromCompiledUnitType(unitType);
    });
    aiPlayers.forEach((String id, shared.Player player) {
      ClientPlayer newPlayer = ClientPlayer()..fromSharedPlayer(player);
      appService.players[id] = newPlayer;
      if (newPlayer.id == clientTaleData.playerIdOnThisClientMachine) {
        appService.currentPlayer = newPlayer;
      }
    });
    gameService.setPlayersOnMoveByIds(clientTaleData.playerOnMoveIds);
    gameService.onTaleLoaded.add(clientTaleData.world);
  }
}
