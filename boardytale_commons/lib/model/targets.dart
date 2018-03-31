part of model;

class Targets {
  /// MAIN - EVERY ABILITY HAVE ONE
  static const TARGET_ENEMY = "enemy";
  static const TARGET_EMPTY = "empty";
  static const TARGET_ALLY = "ally";
  static const TARGET_TEAM = "team";
  static const TARGET_CORPSE = "corpse";
  static const TARGET_ME = "me";
  static const TARGETS = const [TARGET_ENEMY, TARGET_EMPTY, TARGET_ALLY, TARGET_CORPSE, TARGET_ME];

  /// MODIFICATORS OF TARGET
  static const TARGET_WOUNDED = "wounded";
  static const TARGET_NOT_UNDEAD = "not_undead";
  static const TARGET_UNDEAD = "undead";
  static const MODIFICATORS = const [TARGET_WOUNDED, TARGET_NOT_UNDEAD, TARGET_UNDEAD];

  List<String> me;
  List<String> empty;
  List<String> enemy;
  List<String> ally;
  List<String> team;
  List<String> corpse;

  static Map<String, CheckUnit> checkUnits = {
    TARGET_WOUNDED: (Unit unit) => unit.actualHealth != unit.type.health,
    TARGET_UNDEAD: (Unit unit) => unit.tags.contains(UnitType.TAG_UNDEAD),
    TARGET_NOT_UNDEAD: (Unit unit) => !unit.tags.contains(UnitType.TAG_UNDEAD)
  };

  void fromList(List<String> targetList) {
    for (String group in targetList) {
      _parseTarget(group);
    }
  }

  bool match(Unit unit, Track track) {
    List<Unit> alives = track.last.alivesOnField();
    if (track.fields.length == 1) {
      if (me == null) return false;
      if (me.length == 0) return true;
      return matchUnit(unit, me);
    }
    if (!alives.isEmpty) {
      Unit firstUnit = alives.first;
      if (firstUnit.player.id == unit.player.id) {
        if (ally == null) return false;
        if (ally.length == 0) return true;
        return alives.any((Unit unit) => matchUnit(unit, ally));
      } else {
        if (firstUnit.player.team == unit.player.team) {
          if (team == null) return false;
          if (team.length == 0) return true;
          return alives.any((Unit unit) => matchUnit(unit, team));
        } else {
          if (enemy == null) return false;
          if (enemy.length == 0) return true;
          return alives.any((Unit unit) => matchUnit(unit, enemy));
        }
      }
    }
    List<Unit> corpses = track.last.deathsOnField();
    if (!corpses.isEmpty) {
      if (corpse == null) return false;
      if (corpse.length == 0) return true;
      return corpses.any((Unit unit) => matchUnit(unit, corpse));
    } else {
      if (empty == null) return false;
      return true;
    }
  }

  bool matchUnit(Unit unit, List<String> modificators) {
    return modificators.every((String modificator) => checkUnits[modificator](unit));
  }

  void _parseTarget(String group) {
    List<String> parts = group.split("-");
    String mainTarget;
    List<String> others = [];
    for (var i = 0; i < parts.length; i++) {
      var part = parts[i];
      if (TARGETS.contains(part)) {
        mainTarget = part;
        continue;
      }
      if (!MODIFICATORS.contains(part)) {
        throw "Unknown TargetModificator: $part";
      }
      others.add(part);
    }
    switch (mainTarget) {
      case TARGET_ME:
        me = others;
        return;
      case TARGET_ALLY:
        ally = others;
        return;
      case TARGET_TEAM:
        team = others;
        return;
      case TARGET_ENEMY:
        enemy = others;
        return;
      case TARGET_EMPTY:
        empty = others;
        return;
      case TARGET_CORPSE:
        corpse = others;
        return;
      default:
        throw "Unknown MainTarget: $mainTarget";
    }
  }

  List<String> toList() {
    List<String> result = [];
    _export("me", me, result);
    _export("empty", empty, result);
    _export("corpse", corpse, result);
    _export("ally", ally, result);
    _export("team", team, result);
    _export("enemy", team, result);
    return result;
  }

  static void _export(String name, List<String> modificators, List<String> result) {
    if (modificators == null) return;
    if (modificators.length == 0) {
      result.add(name);
      return;
    }
    result.add("$name-${modificators.join("-")}");
  }
}

typedef bool CheckUnit(Unit unit);
