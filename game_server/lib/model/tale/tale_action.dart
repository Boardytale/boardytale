part of game_server;

class TaleAction {
  String actionId;
  List<ServerPlayer> newPlayersToTale = [];
  String removePlayerId;
  List<String> playersOnMove;
  List<core.UnitType> newUnitTypesToTale = [];
  core.Assets newAssetsToTale;
  List<core.UnitCreateOrUpdateAction> unitUpdates = [];
  core.ShowBanterAction banterAction;
}
