part of boardytale.server.model;

class Clock {
  int teamPlaying = 1;
  final Duration roundDuration = const Duration(seconds: 30);
  Timer timer;
  final Notificator onNextTeam = new Notificator();

  final List<Player> players;
  final ServerTale tale;
  final List<Player> _playerTeam1;
  final List<Player> _playerTeam2;

  Clock(this.players, this.tale)
      : _playerTeam1 = _extractTeam(players, 1),
        _playerTeam2 = _extractTeam(players, 2);

  bool get paused => timer == null;

  void pause() {
    timer.cancel();
    timer = null;
  }

  void start() {
    teamPlaying=2;
    nextTeam();
  }

  void nextTeam() {
    teamPlaying = (teamPlaying % 2) + 1;
    if (timer != null) {
      timer.cancel();
    }
    resetMoves(teamPlaying);
    onNextTeam.notify();
    timer = new Timer(roundDuration, nextTeam);
  }
  List<Player> get currentPlayers{
    if(teamPlaying==1){
      return _playerTeam1;
    }else{
      return _playerTeam2;
    }
  }

  void resetMoves(int team) {
    currentPlayers.forEach((Player player) {
      player.roundDone = false;
    });
    tale.units.forEach((int, model_lib.Unit unit) {
      if (unit.player.team == team) {
        unit.newTurn();
      }
    });
  }

  void skipFromPlayer(Player player) {
    player.roundDone = true;

    bool allSkipped = currentPlayers.every((Player otherPlayer) => otherPlayer.roundDone);
    if (allSkipped) {
      nextTeam();
    }
  }

  bool isPlayerPlaying(Player player) => player.team == teamPlaying;

  static List<Player> _extractTeam(List<Player> players, int team) {
    List<Player> ids = <Player>[];
    for (Player player in players) {
      if (player.team == team) {
        ids.add(player);
      }
    }
    return ids;
  }
}
