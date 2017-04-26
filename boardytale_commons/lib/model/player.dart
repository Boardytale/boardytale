part of model;

class Player{
  int id;
  String name;
  int team;
  String handler;
  static const List _possibleHandlers = const["firstHuman", "UI", "passive", "everyHuman"];

  void fromMap(Map data) {
    // TODO validate here
    id = data["id"];
    name = data["name"];
    team = data["team"];

    dynamic __handler = data["handler"];
    if(__handler is String && _possibleHandlers.contains(__handler)){
      handler = __handler;
    }else{
      throw "Key handler is obligatory and must be one of $_possibleHandlers";
    }
  }

  Map toMap() {
    return {
      "id": id,
      "name": name,
      "team": team,
      "handler": handler
    };
  }
}
