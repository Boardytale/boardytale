part of model;

class UnitType {
  static const TAG_UNDEAD = "undead";
  static const TAG_ETHERNAL = "ethernal";
  String _id;
  Race _race;
  int _health;
  int _armor;
  int _speed;
  int _range;
  int _actions = 1;
  List<int> _attack;
  int _cost;
  List<Ability> _abilities = new List<Ability>();
  List<String> tags = [];
  List<Map> _abilitiesData;
  String _imageId;
  String _name;
  Image image;
  String bigImageId;
  Image bigImage;
  String iconId;
  Image iconImage;
  Notificator onChange = new Notificator();

  String raceId;

  List<Map> get abilitiesData => _abilitiesData;

  String get id => _id;

  String get name => _name;

  Race get race => _race;

  int get health => _health;

  int get armor => _armor;

  int get speed => _speed;

  int get range => _range;

  int get actions => _actions;

  List<int> get attack => _attack;

  int get cost => _cost;

  List<Ability> get abilities => _abilities;

  String get imageId => _imageId;

  set id(String val) {
    _id = val;
    onChange.notify();
  }

  set race(Race val) {
    _race = val;
    onChange.notify();
  }

  set health(int val) {
    _health = val;
    onChange.notify();
  }

  set armor(int val) {
    _armor = val;
    onChange.notify();
  }

  set speed(int val) {
    _speed = val;
    onChange.notify();
  }

  set range(int val) {
    _range = val;
    onChange.notify();
  }

  set actions(int val) {
    _actions = val;
    onChange.notify();
  }

  set attack(List<int> val) {
    _attack = val;
    onChange.notify();
  }

  set cost(int val) {
    _cost = val;
    onChange.notify();
  }

  void fromMap(Map data) {
    dynamic __id = data["id"];
    _id = __id.toString();
    dynamic __name = data["name"];
    if (__name is String) {
      _name = __name;
    } else {
      _badData("name");
    }
    dynamic __race = data["race"];
    if (__race is String) {
      raceId = __race;
    } else {
      _badData("race");
    }
    dynamic __health = data["health"];
    if (__health is int) {
      _health = __health;
    } else {
      _badData("health");
    }
    dynamic __armor = data["armor"];
    if (__armor is int) {
      _armor = __armor;
    } else {
      _badData("armor");
    }
    dynamic __speed = data["speed"];
    if (__speed is int) {
      _speed = __speed;
    } else {
      _badData("speed");
    }
    dynamic __range = data["range"];
    if (__range is int) {
      _range = __range;
    } else if (__range != null) {
      _badData("range");
    }
    dynamic __actions = data["actions"];
    if (__actions is int) {
      _actions = __actions;
    } else if (__actions != null) {
      _badData("actions");
    }
    dynamic __attack = data["attack"];
    if (__attack is List<int>) {
      _attack = __attack;
    } else if (__attack is String) {
      _attack = __attack.split(" ").map((String s)=>int.parse(s)).toList();
    } else {
      _badData("attack");
    }
    if (_attack.length != 6) {
      throw "Attack has 6 numbers";
    }
    dynamic __cost = data["cost"];
    if (__cost is int) {
      _cost = __cost;
    } else {
      _badData("cost");
    }

    dynamic __abilitiesData = data["abilities"];
    if (__abilitiesData is List) {
      _abilitiesData = __abilitiesData;
    } else {
      _badData("abilities data");
    }

    dynamic __imageId = data["imageId"];
      _imageId = __imageId.toString();

    dynamic __bigImageId = data["bigImageId"];
    if(__bigImageId != null){
//      if (__bigImageId is String) {
        bigImageId = __bigImageId.toString();
//      } else {
//        _badData("bigImageId");
//      }
    }
    dynamic __iconId = data["iconId"];
    if(__iconId != null){
      iconId = __iconId.toString();
//      if (__iconId is String) {
//      } else {
//        _badData("iconId");
//      }
    }
  }

  Map toMap() {
    Map<String,dynamic> out = <String,dynamic>{};
    out["id"] = _id;
    out["name"] = _name;
    out["race"] = _race.id;
    out["health"] = _health;
    out["armor"] = _armor;
    out["speed"] = _speed;
    out["range"] = _range;
    out["actions"] = _actions;
    out["attack"] = _attack.join(" ");
    out["cost"] = _cost;
    out["abilities"] = _abilitiesData;
    out["imageId"] = _imageId;
    out["bigImageId"] = bigImageId;
    out["iconId"] = iconId;
    return out;
  }

  void _badData(String key) {
    throw "key $key is not ok";
  }
}
