part of model;

@Typescript()
@JsonSerializable()
class World {
  int width;
  int height;
  Terrain baseTerrain = Terrain.grass;
  Map<String, FieldCreateEnvelope> fields = {};
  List<String> startingFieldIds = [];

  World();

  factory World.fromJson(Map<String, dynamic> json) =>
      _$WorldFromJson(json);

  Map toJson() {
    return _$WorldToJson(this);
  }

  static Map<String, Field> createFields(World envelope,
      Field Function(String key) fieldInstanceGenerator) {
    Map<String, Field> fields = {};
    for (int x = 0; x < envelope.width; x++) {
      for (int y = 0; y < envelope.height; y++) {
        String key = "${x}_$y";
        Field field = fieldInstanceGenerator(key);
        if (envelope.fields.containsKey(key)) {
          field.terrain = envelope.fields[key].terrain;
        } else {
          field.terrain = envelope.baseTerrain;
        }
        fields[key] = field;
      }
    }
    return fields;
  }

  static Map<String, FieldCreateEnvelope> createFieldsData(
      World envelope) {
    Map<String, FieldCreateEnvelope> fieldsData = envelope.fields;
    Map<String, FieldCreateEnvelope> indexedFieldsData = {};
    if (fieldsData != null) {
      fieldsData.forEach((String k, FieldCreateEnvelope v) {
        if (v is int) {
          indexedFieldsData[k] = v;
        }
        if (v is Map<String, dynamic>) {
          indexedFieldsData[k] = FieldCreateEnvelope()
            ..terrain = envelope.baseTerrain;
        }
      });
    }
    return fieldsData;
  }
}
