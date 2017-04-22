part of deskovka_client;

class MatchmakingGamesWidget extends Widget{
  String path = "matchmaking/games";
  MatchmakingWidget matchmaking;
  List get games=>gf.matchmaking.games;
  MatchmakingGamesWidget(this.matchmaking):super(){
    matchmaking.matchmaking.onGamesChanged.add(requestRepaint);
  }

  @override
  void destroy(){
    // TODO: implement destroy
  }

  @override
  Map out(){
    Map out = {};
    List gameList = [];
    for(Map game in games){
      Map newGame = {};
      newGame["gold"] = game["gold"];
      newGame["lang"] = widgetLang;
      newGame["host"] = game["players"][0]["nick"];
      newGame["id"] = game["id"];
      gameList.add(newGame);
    }
    out["games"] = gameList;
    out["lang"] = widgetLang;
    return out;
  }

  @override
  void setChildrenTargets(){
    // do nothing
  }

  @override
  void tideFunctionality(){
    for(Map game in games){
      if(matchmaking.selected == null){
        matchmaking.selected = races.values.first;
      }
      Element gameDiv = target.querySelector("#game_${game["id"]}");
      gameDiv.onClick.listen((_){
        gf.send(ACTION_ENTER_GAME, {"gameId": game["id"], "race": matchmaking.selected.id});
      });
    }
  }
}