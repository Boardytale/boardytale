part of model;

class Track {
  List<Field> fields;

  Field get last => fields.last;

  Track(this.fields) {
    if (fields == null) {
      fields = [];
    }
  }

  bool get isEmpty => fields.isEmpty;

  Field get first => fields.first;

  bool isEnemy(Player ofPlayer) {
    for (Field f in fields) {
      if (!f.units.isEmpty && f.units.first.player != ofPlayer) {
        return true;
      }
    }
    return false;
  }

  List<Field> getFieldsWithEnemy(Player ofPlayer) {
    List<Field> out = [];
    for (Field f in fields) {
      if (!f.units.isEmpty && f.units.first.player != ofPlayer) {
        out.add(f);
      }
    }
    return out;
  }


  bool matchTarget(List<String> target, Unit unit) {
    List<Unit> alives = last.alivesOnField();
    if (fields.length == 1 && target.contains(Ability.TARGET_ME)) {
      return true;
    }
    if (target.contains(Ability.TARGET_FIELD)) {
      return alives.isEmpty;
    }
    if (alives.isEmpty) {
      List<Unit> deaths = last.deathsOnField();
      if (target.contains(Ability.TARGET_CORPSE)) {
        return !deaths.isEmpty;
      }
      if (target.contains(Ability.TARGET_NOT_UNDEAD_CORPSE)) {
        return someNotUndead(deaths);
      }
    } else {
      if (alives.first.player == unit.player) {
        if (target.contains(Ability.TARGET_ALLY)) {
          return true;
        }
        if (target.contains(Ability.TARGET_WOUNDED_ALLY)
            && containsWounded(alives)) {
          return true;
        }
      } else {
        if (target.contains(Ability.TARGET_ENEMY)) {
          return true;
        }
        if (target.contains(Ability.TARGET_WOUNDED_ENEMY)
            && containsWounded(alives)) {
          return true;
        }
      }
    }
    return true;
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

//  Map toJson() {
//    List out = [];
//    for (Field f in fields) {
//      out.add(f.toMap());
//    }
//    return {"fields": out};
//  }

//  void fromJson(Map data, World world) {
//    List fields = data["fields"];
//    for (Map f in fields) {
//      this.fields.add(world.fields[f["id"]]);
//    }
//  }
}