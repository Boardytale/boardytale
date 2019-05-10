part of game_server;

class ServerTriggers {
  final core.Triggers triggers;
  final ServerTale tale;

  ServerTriggers(this.tale, this.triggers) {
    triggers.onInit.forEach(onInit);
    tale.events.onUnitDies.listen((report) {
      triggers.onUnitDies.forEach(onUnitDies);
    });
  }

  void onInit(core.Trigger trigger){
    if(trigger.condition == null){
      if(trigger.action.showBanterAction != null){
        showBanterAction(trigger.action.showBanterAction);
      }
    }
  }

  void showBanterAction(core.ShowBanterAction action){
    tale.taleState.addTaleAction(TaleAction()..banterAction = action);
  }

  void onUnitDies(core.UnitTrigger trigger) {
    if (trigger.action.victoryCheckAction != null) {
      var victory = trigger.action.victoryCheckAction;
      Set<String> livingTeams = Set();
      tale.taleState.units.forEach((key, value) {
        if (value.isAlive) {
          livingTeams.add(value.player.team);
        }
      });
      if (victory.allOfTeamsEliminatedForLost != null) {
        if (victory.allOfTeamsEliminatedForLost.every((team) => !livingTeams.contains(team))) {
          tale.lost();
        }
      }
      if (victory.allTeamsEliminatedForWin != null) {
        if (victory.allTeamsEliminatedForWin.every((team) => !livingTeams.contains(team))) {
          tale.victory();
        }
      }
      if (victory.anyOfTeamsEliminatedForLost != null) {
        if (victory.anyOfTeamsEliminatedForLost.any((team) => !livingTeams.contains(team))) {
          tale.lost();
        }
      }
      if (victory.anyOfTeamsEliminatedForWin != null) {
        if (victory.anyOfTeamsEliminatedForWin.any((team) => !livingTeams.contains(team))) {
          tale.victory();
        }
      }
      if (victory.unitsEliminatedForLost != null) {
        if (victory.unitsEliminatedForLost.any((unitId) {
          var unit = tale.taleState.units[unitId];
          if (unit == null) {
            return true;
          }
          return !unit.isAlive;
        })) {
          tale.lost();
        }
      }
    }
  }
}
