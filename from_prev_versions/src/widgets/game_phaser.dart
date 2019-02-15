part of deskovka_client;

class PhaserWidget extends Widget {
  String path = "game/phaser";
  PhaserWidget() : super() {
    target =
        divFactory(0, window.innerWidth ~/ 2 - 40, 40, 80, "game_phaser", "");
    document.body.append(target);
    repaints.add(repaint);
    window.onResize.listen((_) {
      target.style.left = "${window.innerWidth ~/ 2 - 40}px";
    });
    gf.game.playerOnMoveChanged.add(requestRepaint);
  }

  @override
  void destroy() {
    // do nothing
  }

  @override
  Map out() {
    Map out = {};
    out["lang"] = widgetLang;
    if (gf.game.playerOnMove != null) {
      out["onMoveNick"] = gf.game.playerOnMove.nick;
    }
    return out;
  }

  @override
  void setChildrenTargets() {
    // TODO: implement setChildrenTargets
  }

  @override
  void tideFunctionality() {
    target.querySelector("button").onClick.listen((e) {
      gf.game.newTurn();
    });
  }
}
