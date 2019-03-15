part of model;

class Track {
  final List<Field> fields;

  Field get last => fields.last;

  Track(this.fields) {}

  Track.fromIds(List<String> path, World world)
      : fields = _fieldsFromIds(path, world);

  Track.shorten(Track previous, int removeLastCount)
      : fields =
  previous.fields.sublist(0, previous.fields.length - removeLastCount);

  List<String> toIds() {
    return this.fields.map((f)=>f.id).toList();
  }

  static List<Field> _fieldsFromIds(List<String> path, World world) {
    return path.map((String id) => world.fields[id]).toList();
  }

  bool get isEmpty => fields.isEmpty;

  List<String> get path =>
      fields.map((Field field) => field.id).toList(growable: false);

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

  bool isFreeWay(Player ofPlayer) {
    if (fields.length >= 2) {
      Field toGo = fields[fields.length - 2];
      if (!toGo.units.isEmpty && toGo.units.first.player != ofPlayer)
        return false;
    }
    if (fields.length >= 3) {
      for (var i = 1; i < fields.length - 2; i++) {
        Field f = fields[i];
        if (!f.units.isEmpty && f.units.first.player.team != ofPlayer.team)
          return false;
      }
    }
    return true;
  }

  int getMoveCostOfFreeWay(){
    int cost = 0;
    for(int i = 1;i<fields.length;i++){
      if(fields[i].terrain == Terrain.forest){
        cost +=2;
      }else{
        cost +=1;
      }
    }
    return cost;
  }

  bool isHandMove(Player ofPlayer) {
    if (fields.length >= 3) {
      Field toGo = fields[fields.length - 2];
      if (!toGo.units.isEmpty && toGo.units.first.player != ofPlayer)
        return false;
    }
    if (fields.length >= 4) {
      for (var i = 1; i < fields.length - 2; i++) {
        Field f = fields[i];
        if (!f.units.isEmpty && f.units.first.player.team != ofPlayer.team)
          return false;
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
