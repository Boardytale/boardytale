part of model;

@Typescript()
@JsonSerializable()
class WorldCreateEnvelope {
  int width;
  int height;
  Terrain baseTerrain = Terrain.grass;
  Map<String, FieldCreateEnvelope> fields = {};
  String startFieldId;

  WorldCreateEnvelope();

  factory WorldCreateEnvelope.fromJson(Map<String, dynamic> json) =>
      _$WorldCreateEnvelopeFromJson(json);

  Map toJson() {
    return _$WorldCreateEnvelopeToJson(this);
  }
}

class World {
  int width;
  int height;
  Terrain baseTerrain = Terrain.grass;
  Map<String, Field> fields = {};
  Field startField;
  Tale clientTaleService;

  World();

//  Field operator [](String fieldId) => fields[fieldId];

  void fromEnvelope(WorldCreateEnvelope envelope, Field Function(String key, World world) fieldInstanceGenerator) {
    width = envelope.width;
    height = envelope.height;
    fields.clear();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        String key = "${x}_$y";
        Field field = fieldInstanceGenerator(key, this);
        if (envelope.fields.containsKey(key)) {
          field.terrain = envelope.fields[key].terrain;
        } else {
          field.terrain = baseTerrain;
        }
        fields[key] = field;
      }
    }
    dynamic __startFieldId = envelope.startFieldId;
    if (__startFieldId is String) {
      startField = fields[__startFieldId];
    } else {
      throw "Start field must be set";
    }
  }

  Map<String, FieldCreateEnvelope> createFieldsData(WorldCreateEnvelope envelope){
    Map<String, FieldCreateEnvelope> fieldsData = envelope.fields;
    Map<String, FieldCreateEnvelope> indexedFieldsData = {};
    if (fieldsData != null) {
      fieldsData.forEach((String k, FieldCreateEnvelope v) {
        if (v is int) {
          indexedFieldsData[k] = v;
        }
        if (v is Map<String, dynamic>) {
          indexedFieldsData[k] = FieldCreateEnvelope()
            ..terrain = envelope.baseTerrain
          ;
        }
      });
    }
    return fieldsData;
  }

}
