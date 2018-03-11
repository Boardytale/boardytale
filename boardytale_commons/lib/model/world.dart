part of model;

class World {
  int width;
  int height;
  int baseTerrainId = 0;
  Map<String, Field> fields = {};
  Field startField;
  Tale tale;

  World(this.tale);

  void fromMap(Map data, InstanceGenerator generator) {
    width = data["width"] as int;
    height = data["height"] as int;
    baseTerrainId = data["baseTerrain"] as int;
    Map<String, dynamic> fieldsData = data["fields"] as Map<String, dynamic>;
    Map<String, Map<String, dynamic>> indexedFieldsData = <String, Map<String, dynamic>>{};
    if (fieldsData != null) {
      fieldsData.forEach((String k, dynamic v) {
        if (v is int) {
          indexedFieldsData[k] = <String, int>{"terrain": v};
        }
        if (v is Map<String, dynamic>) {
          indexedFieldsData[k] = v;
        }
      });
    }
    fields.clear();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        String key = "${x}_$y";
        Field field = generator.field(key, this);
        if (indexedFieldsData.containsKey(key)) {
          field.fromMap(indexedFieldsData[key]);
        } else {
          field.terrainId = baseTerrainId;
        }
        fields[key] = field;
      }
    }

    dynamic __startField = data["startField"];
    if (__startField is String) {
      startField = fields[__startField];
    } else {
      throw "Start field must be set";
    }
  }

  Map toMap() {
    Map<String, dynamic> out = <String, dynamic>{};
    out["width"] = width;
    out["height"] = height;
    out["baseTerrain"] = baseTerrainId;
    out["startField"] = startField.id;
    Map<String, int> fieldsData = {};
    fields.forEach((k, v) {
      if (v.terrainId != baseTerrainId) {
        fieldsData[k] = v.terrainId;
      }
    });
    out["fields"] = fieldsData;
    return out;
  }
}
