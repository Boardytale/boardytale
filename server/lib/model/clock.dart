part of boardytale.server.model;

class Clock {
  int teamPlaying = 2;
  final Duration roundDuration = const Duration(seconds: 30);
  Timer timer;

  final List<Player> players;
  final ServerTale tale;
  final List<int> playerTeam1Ids;
  final List<int> playerTeam2Ids;

  Clock(this.players, this.tale):playerTeam1Ids=_extractTeamIds(players,1),playerTeam2Ids=_extractTeamIds(players,2);

  bool get paused => timer == null;

  void pause() {
    timer.cancel();
    timer = null;
  }

  void start() {
    nextTeam();
  }

  void nextTeam() {
    teamPlaying = (teamPlaying % 2) + 1;
    if (timer != null) {
      timer.cancel();
    }
    resetMoves(teamPlaying);
    timer = new Timer(roundDuration, nextTeam);
  }

  void resetMoves(int team) {
    players.where((Player player) => player.team == team).forEach((Player player) {
      player.roundDone=false;
    });
    tale.units.forEach((int,model_lib.Unit unit){
      if(unit.player.team==team){

      }
    });
  }

  void skipFromPlayer(Player player) {}

  bool isPlayerPlaying(Player player) => player.team == teamPlaying;

  static List<int> _extractTeamIds(List<Player> players,int team){
    List<int> ids=<int>[];
    for(Player player in players){
      if(player.team==team){
        ids.add(player.id);
      }
    }
    return ids;
  }
}
