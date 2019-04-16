part of model;

class Track {
  List<Field> fields;

  Field get last => fields.last;

  Track(this.fields) {}

  Track.fromIds(List<String> path, Map<String, Field> fields) : fields = _fieldsFromIds(path, fields);

  Track.clean(List<Field> fields, Map<String, Field> allFields) {
    // shorten on duplicity
    List<String> lastIds = [];
    for (var i = 0; i < fields.length; i++) {
      Field field = fields[i];
      if (field == null) {
        continue;
      }
      int index = lastIds.indexOf(field.id);
      if (index != -1) {
        fields.length = index + 1;
        break;
      }
      lastIds.add(fields[i].id);
    }

    if (fields.isEmpty) {
      this.fields = [];
      return;
    }
    // fill missing
    List<Field> out = [fields.first];
    for (var i = 0; i < fields.length - 1; i++) {
      Field f1 = fields[i];
      Field f2 = fields[i + 1];
      if (!Field.fieldsAreNextEachOther(f1, f2)) {
        List<String> shortestPath = f1.getShortestPath(f2);
        for (var j = 1; j < shortestPath.length - 1; j++) {
          out.add(allFields[shortestPath[j]]);
        }
      }
      out.add(f2);
    }
    // remove triangles
    for (var i = 2; i < out.length - 1;) {
      Field f1 = out[i];
      Field f2 = out[i - 1];
      Field f3 = out[i - 2];
      List<String> f1Circle1 = f1.getCircle1Ids();
      if (f1Circle1.contains(f2.id) && f1Circle1.contains(f3.id)) {
        out.remove(f2);
        i = 2;
      } else {
        i++;
      }
    }
    this.fields = out;
  }

  Track.shorten(Track previous, int removeLastCount)
      : fields = previous.fields.sublist(0, previous.fields.length - removeLastCount);

  List<String> toIds() {
    return this.fields.map((f) => f.id).toList();
  }

  Track subTrack(int startIndex, [int endIndex]) {
    return Track(fields.sublist(startIndex, endIndex));
  }

  static List<Field> _fieldsFromIds(List<String> path, Map<String, Field> fields) {
    return path.map((String id) => fields[id]).toList();
  }

  bool get isEmpty => fields.isEmpty;

  List<String> get path => fields.map((Field field) => field.id).toList(growable: false);

  bool get isConnected {
    Field previous;
    for (Field field in fields) {
      if (previous != null && field.distance(previous) != 1) return false;
      previous = field;
    }
    return true;
  }

  Field get first => fields.first;

  bool isEnemy(Player ofPlayer) {
    for (Field f in fields) {
      if (!f.units.isEmpty && f.units.first.player.team != ofPlayer.team) {
        return true;
      }
    }
    return false;
  }

  bool isFreeWay(Player unitOnMovePlayer) {
    if (!MapUtils.standardCanEnd(fields.last, unitOnMovePlayer)) {
      return false;
    }
    for (var i = 1; i < fields.length - 1; i++) {
      Field field = fields[i];
      if (!MapUtils.standardCanGo(field, unitOnMovePlayer)) {
        return false;
      }
    }
    return true;
  }

  int getMoveCostOfFreeWay() {
    int cost = 0;
    for (int i = 1; i < fields.length; i++) {
      if (fields[i].terrain == Terrain.forest) {
        cost += 2;
      } else {
        cost += 1;
      }
    }
    return cost;
  }

  int getEndIndexWithSteps(int steps) {
    int cost = 0;
    for (int i = 1; i < fields.length; i++) {
      if (fields[i].terrain == Terrain.forest) {
        cost += 2;
      } else {
        cost += 1;
      }
      if (cost > steps) {
        return i - 1;
      }
    }
    return fields.length - 1;
  }

  bool isHandMove(Player ofPlayer) {
    if (fields.length >= 3) {
      Field toGo = fields[fields.length - 2];
      if (!toGo.units.isEmpty && toGo.units.first.player != ofPlayer) return false;
    }
    if (fields.length >= 4) {
      for (var i = 1; i < fields.length - 2; i++) {
        Field f = fields[i];
        if (!f.units.isEmpty && f.units.first.player.team != ofPlayer.team) return false;
      }
    }
    return true;
  }

  List<Field> getFieldsWithEnemy(Player ofPlayer) {
    List<Field> out = [];
    for (Field f in fields) {
      if (!f.units.isEmpty && f.units.first.player.team != ofPlayer.team) {
        out.add(f);
      }
    }
    return out;
  }

  bool containsWounded(List<Unit> alives) {
    for (Unit u in alives) {
      if (u.actualHealth != u.type.health) {
        return true;
      }
    }
    return false;
  }

  bool someNotUndead(List<Unit> units) {
    for (Unit unit in units) {
      if (!unit.isUndead) {
        return true;
      }
    }
    return false;
  }
}
