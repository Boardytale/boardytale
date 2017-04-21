part of model;

class Race {
  String _id;
  String _name;
  List<UnitType> _unitTypes = new List<UnitType>();
  Notificator onChange = new Notificator();
  String get id => _id;
  String get name => _name;
  List<UnitType> get unitTypes => _unitTypes;
  set id(String val) {
    _id = val;
    onChange.notify();
  }

  set name(String val) {
    _name = val;
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
  }

  Map toMap() {
    Map out = {};
    out["id"] = _id;
    out["name"] = _name;
    return out;
  }

  void _badData(String key) {
    throw "key $key is in bad";
  }
}
