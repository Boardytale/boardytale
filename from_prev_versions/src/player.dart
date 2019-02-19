part of deskovka_client;

class ClientPlayer extends PlayerBase {
  String state = null;
  ClientWorld world;

  ClientPlayer(String id) : super(id);

  void fromJson(Map json) {
    nick = json["nick"];
    id = json["id"];
    race = races[json["race"]];
    state = json["state"];
    gold = json["gold"];
    left = json["left"];
    you = json["you"];
  }

  Map toJson() {
    Map out = {};
    out["race"] = race.id;
    out["id"] = id;
    out["nick"] = nick;
    out["gold"] = gold;
    out["left"] = left;
    out["you"] = you;
    return out;
  }
}
