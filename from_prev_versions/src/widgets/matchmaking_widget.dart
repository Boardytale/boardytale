part of deskovka_client;

class MatchmakingWidget extends Widget{
  MatchMaking matchmaking;
  OverlayDiv overlay;
  Race selected;
  String path = "matchmaking/matchmaking";

  MatchmakingWidget(this.matchmaking):super(){
    overlay = new OverlayDiv("matchmaking");
    target = overlay.div;

    children.add(new MatchmakingPlayersWidget(this));
    children.add(new MatchmakingGamesWidget(this));

    repaints.add(repaint);
    matchmaking.onDestroy.add(destroy);
  }

  @override
  void destroy(){
    matchmaking.onDestroy.remove(destroy);
    if(overlay != null){
      overlay.destroy();
    }
  }

  @override
  Map out(){
    List nations = [];
    races.forEach((k, v){
      nations.add({"id": k, "name": v.name, "color": v.color});
    });
    Map out = {};
    out["nations"] = nations;
    out["lang"] = lang;
    return out;
  }

  @override
  void setChildrenTargets(){
    getChildByName("players").target = target.querySelector(".players");
    getChildByName("games").target = target.querySelector(".games");
  }

  @override
  void tideFunctionality(){
    races.forEach((k, v){
      Element nation = target.querySelector("#nation_$k");
      nation.onClick.listen((e){
        target.querySelectorAll(".nation").classes.remove("selected");
        nation.classes.add("selected");
        selected = v;
      });
    });



    target.querySelector("button").onClick.listen((e){
      int gold = int.parse((target.querySelector("#gold") as InputElement).value, onError: (e)=> 50);

      if(selected == null){
        selected = races.values.first;
      }
      gf.send(ACTION_HOST, {"gold": gold, "race": selected.id});
    });
  }
}