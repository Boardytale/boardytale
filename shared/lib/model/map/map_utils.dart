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

  static List<Field> getNearestEnemyByTerrain(
      Map<String, Unit> units, Unit unitOnMove, Map<String, Field> fields, int steps,
      {bool Function(Field field, Player unitOnMovePlayer) canGoHere = MapUtils.standardCanGo,
      bool Function(Field field, Player unitOnMovePlayer) canEndHere = MapUtils.standardCanEnd,
      SimpleLogger logger}) {
    Set<Field> reachedFields = Set();
    List<List<Field>> paths = [
      [unitOnMove.field]
    ];
    int generation = 0;
    Map<int, List<List<Field>>> waitingPaths = {};
    if (logger != null) {
      logger.log += "\n getNearestEnemyByTerrain for unit ${unitOnMove.id} \n";
    }
    while (++generation < 20) {
      if (logger != null) {
        logger.log += "\n generation ${generation} \n";
      }
      List<List<Field>> nextGenPaths = [];
      for (int i = 0; i < paths.length; i++) {
        List<Field> currentGenPath = paths[i];
        if (logger != null) {
          logger.log += "\n currentGenPath ${currentGenPath.map((f) => f.id).join(" ")} \n";
        }
        for (int i = 0; i < 6; i++) {
          Field nextField = fields[currentGenPath.last.stepToDirection(i)];
          if (logger != null) {
            logger.log += "next field ${nextField?.id}";
          }
          // out of map
          if (nextField == null) {
            continue;
          }
          if (reachedFields.contains(nextField)) {
            if (logger != null) {
              logger.log += "skipped reached \n";
            }
            continue;
          }
          if (nextField.units.isNotEmpty && nextField.isEnemyOf(unitOnMove.player)) {
            if (canEndHere(currentGenPath.last, unitOnMove.player)) {
              if (logger != null) {
                logger.log += "returned is enemy \n";
              }
              return currentGenPath.toList()..add(nextField);
            } else {
              if (logger != null) {
                logger.log += "skipped cannot end on last \n";
              }
              continue;
            }
          }
          if (!canGoHere(nextField, unitOnMove.player)) {
            if (logger != null) {
              logger.log += "skipped cannot go \n";
            }
            continue;
          }
          if (unitOnMove.steps == generation) {
            if (logger != null) {
              logger.log += " - unit can end here by steps - \n";
            }

            if (!canEndHere(nextField, unitOnMove.player)) {
              if (logger != null) {
                logger.log += "skipped cannot end here on steps \n";
              }
              continue;
            }
          }
          if (nextField.terrain == Terrain.forest) {
            if (waitingPaths[generation + 1] == null) {
              waitingPaths[generation + 1] = [];
            }
            waitingPaths[generation + 1].add(currentGenPath.toList()..add(nextField));
            if (logger != null) {
              logger.log += "skipped waiting forest \n";
            }
            continue;
          }
          reachedFields.add(nextField);
          nextGenPaths.add(currentGenPath.toList()..add(nextField));
          if (logger != null) {
            logger.log += "added to possible paths \n";
          }
        }
      }
      if (waitingPaths.containsKey(generation)) {
        nextGenPaths.addAll(waitingPaths[generation]);
      }
      paths = nextGenPaths;
    }
    return null;
  }

  static bool standardCanGo(Field field, Player unitOnMovePlayer) {
    return field.terrain != Terrain.rock && field.terrain != Terrain.water && !field.isEnemyOf(unitOnMovePlayer);
  }

  static bool standardCanEnd(Field field, Player unitOnMovePlayer) {
    return field.terrain != Terrain.rock && field.terrain != Terrain.water && !field.anyAliveOnField();
  }
}
