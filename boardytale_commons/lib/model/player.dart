part of model;

class Player{
  int id;
  String name;
  int team;
  String handler;
  static const List<String> _possibleHandlers = const["firstHuman", "UI", "passive", "everyHuman"];

  void fromMap(Map<String,dynamic> data) {
    // TODO validate here
    id = data["id"] as int;
    name = data["name"] as String;
    team = data["team"] as int;

    dynamic __handler = data["handler"];
    if(__handler is String && _possibleHandlers.contains(__handler)){
      handler = __handler;
    }else{
      throw "Key handler is obligatory and must be one of $_possibleHandlers";
    }
  }

  Map<String,dynamic> toMap() {
    return <String,dynamic>{
      "id": id,
      "name": name,
      "team": team,
      "handler": handler
    };
  }
}
