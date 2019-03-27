part of game_server;

class ServerTriggers {
  final shared.Triggers triggers;
  final ServerTale tale;

  ServerTriggers(this.tale, this.triggers) {
    tale.events.onUnitDies.listen((report) {
      triggers.onUnitDies.forEach((trigger) {
        if (trigger.action.victoryCheckAction != null) {
          var victory = trigger.action.victoryCheckAction;
          Set<String> livingTeams = {};
          tale.units.forEach((key, value){
            if(value.isAlive){
              livingTeams.add(value.player.team);
            }
          });
          if(victory.allOfTeamsEliminatedForLost != null){
            if(victory.allOfTeamsEliminatedForLost.every((team)=>!livingTeams.contains(team))){
              tale.lost();
            }
          }
          if(victory.allTeamsEliminatedForWin != null){
            if(victory.allTeamsEliminatedForWin.every((team)=>!livingTeams.contains(team))){
              tale.victory();
            }
          }
          if(victory.anyOfTeamsEliminatedForLost != null){
            if(victory.anyOfTeamsEliminatedForLost.any((team)=>!livingTeams.contains(team))){
              tale.lost();
            }
          }
          if(victory.anyOfTeamsEliminatedForWin != null){
            if(victory.anyOfTeamsEliminatedForWin.any((team)=>!livingTeams.contains(team))){
              tale.victory();
            }
          }
          if(victory.unitsEliminatedForLost != null){
            if(victory.unitsEliminatedForLost.any((unitId){
              var unit = tale.units[unitId];
              if(unit == null){
                return true;
              }
              return !unit.isAlive;
            })){
              tale.lost();
            }
          }
        }
      });
    });
  }
}
