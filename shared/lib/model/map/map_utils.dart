part of model;

class MapUtils {
  static List<Field> getShortestPathWithTerrain(Field fromField, Field toField, Map<String, Field> fields) {
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
            if (nextField.terrain == Terrain.rock || nextField.terrain == Terrain.water) {
              return [];
            }
            return currentGenPath.toList()..add(nextField);
          }
          if (reachedFields.contains(nextField)) {
            continue;
          }
          if (nextField.terrain == Terrain.rock || nextField.terrain == Terrain.water) {
            continue;
          }
          if (nextField.terrain == Terrain.forest) {
            if (waitingPaths[generation + 1] == null) {
              waitingPaths[generation + 1] = [];
            }
            waitingPaths[generation + 1].add(currentGenPath.toList()..add(nextField));
            continue;
          }
          reachedFields.add(nextField);
          nextGenPaths.add(currentGenPath.toList()..add(nextField));
        }
      }
      if (waitingPaths.containsKey(generation)) {
        nextGenPaths.addAll(waitingPaths[generation]);
      }
      paths = nextGenPaths;
    }
    return null;
  }


  static List<Field> getNearestEnemyByTerrain(Map<String, Unit> units, Unit ofUnit, Map<String, Field> fields) {
    Set<Field> reachedFields = Set();
    List<List<Field>> paths = [
      [ofUnit.field]
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
          if(nextField.units.isNotEmpty && nextField.units.first.player.team != ofUnit.player.team){
            return currentGenPath.toList()..add(nextField);
          }
          if (reachedFields.contains(nextField)) {
            continue;
          }
          if (nextField.terrain == Terrain.rock || nextField.terrain == Terrain.water) {
            continue;
          }

          if (nextField.terrain == Terrain.forest) {
            if (waitingPaths[generation + 1] == null) {
              waitingPaths[generation + 1] = [];
            }
            waitingPaths[generation + 1].add(currentGenPath.toList()..add(nextField));
            continue;
          }
          reachedFields.add(nextField);
          nextGenPaths.add(currentGenPath.toList()..add(nextField));
        }
      }
      if (waitingPaths.containsKey(generation)) {
        nextGenPaths.addAll(waitingPaths[generation]);
      }
      paths = nextGenPaths;
    }
    return null;
  }
}
