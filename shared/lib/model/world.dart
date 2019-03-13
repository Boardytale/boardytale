part of model;

@Typescript()
@JsonSerializable()
class WorldCreateEnvelope {
  int width;
  int height;
  Terrain baseTerrain = Terrain.grass;
  Map<String, FieldCreateEnvelope> fields = {};
  List<String> startingFieldIds = [];

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
  List<String> startingFieldIds = [];
  Tale clientTaleService;

  World();

//  Field operator [](String fieldId) => fields[fieldId];

  void fromEnvelope(WorldCreateEnvelope envelope,
      Field Function(String key, World world) fieldInstanceGenerator) {
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
    startingFieldIds = envelope.startingFieldIds;
  }

  Map<String, FieldCreateEnvelope> createFieldsData(
      WorldCreateEnvelope envelope) {
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

  List<Field> getShortestPathWithTerrain(Field fromField, Field toField) {
    if (fromField == toField) {
      return [fromField];
    }
    Set<Field> reachedFields = Set();
    List<List<Field>> paths = [
      [fromField]
    ];
    int generation = 0;
    Map<int, List<List<Field>>> waitingPaths = {};

    while (++generation < 10000) {
      List<List<Field>> nextGenPaths = [];
      for (int i = 0; i < paths.length; i++) {
        List<Field> currentGenPath = paths[i];
        for (int i = 0; i < 6; i++) {
          Field nextField = fields[currentGenPath.last.stepToDirection(i)];
          // out of map
          if (nextField == null) {
            continue;
          }
          if (nextField == toField) {
            if (nextField.terrain == Terrain.rock ||
                nextField.terrain == Terrain.water) {
              return [];
            }
            return currentGenPath.toList()
              ..add(nextField);
          }
          if (reachedFields.contains(nextField)) {
            continue;
          }
          if (nextField.terrain == Terrain.rock ||
              nextField.terrain == Terrain.water) {
            continue;
          }
          if (nextField.terrain == Terrain.forest) {
            if (waitingPaths[generation + 1] == null) {
              waitingPaths[generation + 1 ] = [];
            }
            waitingPaths[generation + 1 ].add(currentGenPath.toList()
              ..add(nextField));
            continue;
          }
          reachedFields.add(nextField);
          nextGenPaths.add(currentGenPath.toList()
            ..add(nextField));
        }
      }
      if (waitingPaths.containsKey(generation)){
        nextGenPaths.addAll(waitingPaths[generation]);
      }
      paths = nextGenPaths;
    }
    return null;
  }
}
