part of model;

class Unit_type {
  String _id;
  String _name;
  String _race;
  int _health;
  int _armor;
  int _speed;
  int _range;
  int _actions;
  List _attack;
  int _cost;
  List<Ability> _abilities = new List<Ability>();
  Notificator onChange = new Notificator();
  String get id => _id;
  String get name => _name;
  String get race => _race;
  int get health => _health;
  int get armor => _armor;
  int get speed => _speed;
  int get range => _range;
  int get actions => _actions;
  List get attack => _attack;
  int get cost => _cost;
  List<Ability> get abilities => _abilities;
  set id(String val) {
    _id = val;
    onChange.notify();
  }

  set name(String val) {
    _name = val;
    onChange.notify();
  }

  set race(String val) {
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

  set attack(List val) {
    _attack = val;
    onChange.notify();
  }

  set cost(int val) {
    _cost = val;
    onChange.notify();
  }

  void fromMap(Map data) {
    dynamic __id = data["id"];
    if (__id is String) {
      _id = __id;
    } else {
      _badData("id");
    }
    dynamic __name = data["name"];
    if (__name is String) {
      _name = __name;
    } else {
      _badData("name");
    }
    dynamic __race = data["race"];
    if (__race is String) {
      _race = __race;
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
    } else {
      _badData("range");
    }
    dynamic __actions = data["actions"];
    if (__actions is int) {
      _actions = __actions;
    } else {
      _badData("actions");
    }
    dynamic __attack = data["attack"];
    if (__attack is List) {
      _attack = __attack;
    } else {
      _badData("attack");
    }
    dynamic __cost = data["cost"];
    if (__cost is int) {
      _cost = __cost;
    } else {
      _badData("cost");
    }
  }

  Map toMap() {
    Map out = {};
    out["id"] = _id;
    out["name"] = _name;
    out["race"] = _race;
    out["health"] = _health;
    out["armor"] = _armor;
    out["speed"] = _speed;
    out["range"] = _range;
    out["actions"] = _actions;
    out["attack"] = _attack;
    out["cost"] = _cost;
    return out;
  }

  void _badData(String key) {
    throw "key $key is in bad";
  }
}
