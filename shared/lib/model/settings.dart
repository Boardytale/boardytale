part of model;

class Settings {
  double defaultFieldWidth = 100.0;

  void fromMap(Map map) {
    if (map['defaultFieldWidth'] is double) {
      defaultFieldWidth = map['defaultFieldWidth'] as double;
    }
  }
}
