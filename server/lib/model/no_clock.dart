part of boardytale.server.model;

class NoClock extends Clock{
  NoClock(List<Player> players, ServerTale tale) : super(players, tale);

  void nextTeam() {
    teamPlaying = (teamPlaying % 2) + 1;
    resetMoves(teamPlaying);
    onNextTeam.notify();
  }

}