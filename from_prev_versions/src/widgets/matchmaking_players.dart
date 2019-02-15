part of deskovka_client;

class MatchmakingPlayersWidget extends Widget {
  String path = "matchmaking/players";
  MatchmakingWidget matchmaking;

  MatchmakingPlayersWidget(this.matchmaking) : super() {
    gf.matchmaking.onPlayersChanged.add(requestRepaint);
  }

  @override
  void destroy() {
    // do nothing
  }

  @override
  Map out() {
    Map out = {};
    List players = [];
    for (Map p in gf.matchmaking.players) {
      players.add(p);
    }
    out["players"] = players;
    out["lang"] = widgetLang;
    return out;
  }

  @override
  void setChildrenTargets() {
    // do nothing
  }

  @override
  void tideFunctionality() {
    // TODO: implement tideFunctionality
  }
}
