part of deskovka_client;

class GameAbilities extends Widget {
  String path = "game/abilities";
  List<Ability> actual = [];
  GameAbilities() : super() {}

  @override
  void destroy() {
    // TODO: implement destroy
  }

  @override
  Map out() {
    Map out = {"abilities": []};
    for (int i = 0; i < actual.length; i++) {
      out["abilities"]
          .add({"img": actual[i].img, "orderClass": "abilityIcon$i"});
    }
    return out;
  }

  @override
  void setChildrenTargets() {
    // TODO: implement setChildrenTargets
  }

  @override
  void tideFunctionality() {
    // TODO: implement tideFunctionality
  }
}
