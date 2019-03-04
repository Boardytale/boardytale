part of model;

@Typescript()
@JsonSerializable()
class FieldCreateEnvelope {
  Terrain terrain;

  Map toJson() {
    return _$FieldCreateEnvelopeToJson(this);
  }

  static FieldCreateEnvelope fromJson(Map json) {
    return _$FieldCreateEnvelopeFromJson(json);
  }
}

class Field {
  List<Unit> units = [];
  String id;
  World world;
  Terrain terrain;
  int x;
  int y;

  bool get hasUnit => !units.isEmpty;

  Field(this.id, this.world) {
    List<String> xy = id.split("_");
    x = int.parse(xy[0]);
    y = int.parse(xy[1]);
  }

  Field.anotherConstructor(this.id, this.world) {
    List<String> xy = id.split("_");
    x = int.parse(xy[0]);
    y = int.parse(xy[1]);
  }

  int get yt => y - (x / 2).floor();

  double get posY => y + (x % 2) / 2;

  List<Unit> alivesOnField() {
    List<Unit> out = [];
    for (Unit unit in units) {
      if (unit.isAlive) {
        out.add(unit);
      }
    }
    return out;
  }

  List<Unit> deathsOnField() {
    List<Unit> out = [];
    for (Unit unit in units) {
      if (!unit.isAlive) {
        out.add(unit);
      }
    }
    return out;
  }

  /// is one or more alive units on field
  bool isAliveOnField() {
    for (Unit unit in units) {
      if (unit.isAlive) return true;
    }
    return false;
  }

  Field getFieldWithUnitNear() {
    if (hasUnit) return this;
//    var fields = World.instance.getFieldsRound(this);
//    for (Field field in fields) {
//      if (field.hasUnit) return field;
//    }
    return null;
  }

  Field getFieldWithAliveUnitNear() {
    if (isAliveOnField()) return this;
//    var fields = World.instance.getFieldsRound(this);
//    for (Field field in fields) {
//      if (field.isAliveOnField()) return field;
//    }
    return null;
  }

  void addUnit(Unit unit) {
    units.add(unit);
  }

  void removeUnit(Unit unit) {
    units.remove(unit);
  }

  bool isAllyOnField(Player player) {
    if (units.isEmpty) return false;
    return units.first.player == player;
  }

  bool isCorpseOnField() {
    for (Unit unit in units) {
      if (!unit.isAlive) return true;
    }
    return false;
  }

  bool areOnlyCorpsesOnField() {
    for (Unit unit in units) {
      if (unit.isAlive) return false;
    }
    return !units.isEmpty;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> out = <String, dynamic>{};
    out["id"] = id;
    out["terrain"] = terrain;
    return out;
  }

  int distance(Field field) {
    int dx = (x - field.x);
    int dy = (yt - field.yt);
    if (dx * dy < 0) {
      return Math.max(dx.abs(), dy.abs());
    }
    return dy.abs() + dx.abs();
  }

  String stepToDirection(int direction) {
    if (x.isEven) {
      switch (direction) {
        case 0:
          return "${x}_${y - 1}";
        case 1:
          return "${x + 1}_${y - 1}";
        case 2:
          return "${x + 1}_${y}";
        case 3:
          return "${x}_${y + 1}";
        case 4:
          return "${x - 1}_${y}";
        case 5:
          return "${x - 1}_${y - 1}";
      }
    } else {
      switch (direction) {
        case 0:
          return "${x}_${y - 1}";
        case 1:
          return "${x + 1}_${y}";
        case 2:
          return "${x + 1}_${y + 1}";
        case 3:
          return "${x}_${y + 1}";
        case 4:
          return "${x - 1}_${y + 1}";
        case 5:
          return "${x - 1}_${y}";
      }
    }
    return null;
  }

  static List<int> stepToDirectionInt(int x, int y, int direction) {
    if (x.isEven) {
      switch (direction) {
        case 0:
          return [x, y - 1];
        case 1:
          return [x + 1, y - 1];
        case 2:
          return [x + 1, y];
        case 3:
          return [x, y + 1];
        case 4:
          return [x - 1, y];
        case 5:
          return [x - 1, y - 1];
      }
    } else {
      switch (direction) {
        case 0:
          return [x, y - 1];
        case 1:
          return [x + 1, y];
        case 2:
          return [x + 1, y + 1];
        case 3:
          return [x, y + 1];
        case 4:
          return [x - 1, y + 1];
        case 5:
          return [x - 1, y];
      }
    }
    return null;
  }

  int directionTo(Field target) {
    int dx = target.x - x;
    int dy = (target.yt - yt);
    if (dx == 0) {
      return dy < 0 ? 0 : 3;
    }
    double ratio = dy / dx;
    if (dx > 0) {
      if (ratio < -2) return 0;
      if (ratio < -0.5) return 1;
      if (ratio < 1) return 2;
      return 3;
    } else {
      if (ratio < -2) return 3;
      if (ratio < -0.5) return 4;
      if (ratio < 1) return 5;
      return 0;
    }
  }

  List<int> bothDirectionTo(Field target) {
    int yt = y - (x / 2).floor();
    int tyt = target.y - (target.x / 2).floor();
    int dx = target.x - x;
    int dy = (tyt - yt);
    if (dx == 0) {
      return dy < 0 ? [0, 1] : [3, 4];
    }
    double ratio = dy / dx;
    if (dx > 0) {
      if (ratio < -2) return [0, 1];
      if (ratio < -1) return [1, 0];
      if (ratio < -0.5) return [1, 2];
      if (ratio < 0) return [2, 1];
      if (ratio < 1) return [2, 3];
      return [3, 2];
    } else {
      if (ratio < -2) return [3, 4];
      if (ratio < -1) return [4, 3];
      if (ratio < -0.5) return [4, 5];
      if (ratio < 0) return [5, 4];
      if (ratio < 1) return [5, 0];
      return [0, 5];
    }
  }

  List<String> getShortestPath(Field target) {
    if (x == target.x) {
      int dy = target.y - y;
      if (dy > 0) {
        return new List.generate(dy + 1, (int index) => "${x}_${y + index}");
      } else {
        return new List.generate(-dy + 1, (int index) => "${x}_${y - index}");
      }
    }
    if (y == target.y) {
      int dx = target.x - x;
      if (dx > 0) {
        return new List.generate(dx + 1, (int index) => "${x + index}_$y");
      } else {
        return new List.generate(-dx + 1, (int index) => "${x - index}_$y");
      }
    }
    List<int> directions = bothDirectionTo(target);
    int primaryDirection = directions.first;
    int secondaryDirection = directions.last;
    int tx = target.x;
    int ty = target.y;
    int mx = x;
    int my = y;
    double toY = target.posY;
    double slope = (toY - posY) / (tx - x);
    double y0 = toY - slope * tx;
//    print("[$tx,$ty] => [$toX,$toY]  y0=$y0 slope=$slope");
    List<String> result = [id];
    while (mx != tx || my != ty) {
      List<int> primary = stepToDirectionInt(mx, my, primaryDirection);
      List<int> secondary = stepToDirectionInt(mx, my, secondaryDirection);
      double pPosY = primary[1] + (primary[0] % 2) / 2;
      double sPosY = secondary[1] + (secondary[0] % 2) / 2;
      double primaryDistance = pPosY - y0 - slope * primary[0];
      double secondaryDistance = sPosY - y0 - slope * secondary[0];
//      double primaryToTarget=Math.pow(primary[0]-toX,2)+Math.pow(primary[1]+(primary[0]%2)/2-toY,2);
//      double secondaryToTarget=Math.pow(secondary[0]-toX,2)+Math.pow(secondary[1]+(secondary[0]%2)/2-toY,2);
//      print("$primary => $primaryDistance ($primaryToTarget)   $secondary => $secondaryDistance ($secondaryToTarget)");
      if (primaryDistance.abs() <= secondaryDistance.abs()) {
        mx = primary[0];
        my = primary[1];
      } else {
        mx = secondary[0];
        my = secondary[1];
      }
      result.add("${mx}_${my}");
    }
//    result.add(target.id);
    return result;
  }
}

@Typescript()
enum Terrain {
  @JsonValue('grass')
  grass,
  @JsonValue('rock')
  rock,
  @JsonValue('water')
  water,
  @JsonValue('forest')
  forest
}
