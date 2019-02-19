part of model;
//
//@Typescript()
//@JsonSerializable()
//class Targets {
//  /// MAIN - EVERY ABILITY HAVE ONE
//  static const TARGET_ME = "me";
//  static const TARGET_ALLY = "ally";
//  static const TARGET_TEAM = "team";
//  static const TARGET_ENEMY = "enemy";
//  static const TARGET_CORPSE = "corpse";
//  static const TARGET_EMPTY = "empty";
//  static const TARGETS = const [
//    TARGET_ME,
//    TARGET_ALLY,
//    TARGET_ENEMY,
//    TARGET_TEAM,
//    TARGET_CORPSE,
//    TARGET_EMPTY
//  ];
//
//  /// MODIFICATORS OF TARGET
//  static const TARGET_WOUNDED = "wounded";
//  static const TARGET_NOT_UNDEAD = "not_undead";
//  static const TARGET_UNDEAD = "undead";
//  static const MODIFICATORS = const [TARGET_WOUNDED, TARGET_NOT_UNDEAD, TARGET_UNDEAD];
//
//  List<String> me;
//  List<String> ally;
//  List<String> team;
//  List<String> enemy;
//  List<String> corpse;
//  List<String> empty;
//
//  Map<String, dynamic> toJson(){
//    return _$TargetsToJson(this);
//  }
//
//  static Targets fromJson(Map<String, dynamic> json){
//    return _$TargetsFromJson(json);
//  }
//
//  static Map<String, CheckUnit> checkUnits = {
//    TARGET_WOUNDED: (Unit unit) => unit.actualHealth != unit.type.health,
//    TARGET_UNDEAD: (Unit unit) => unit.isUndead,
//    TARGET_NOT_UNDEAD: (Unit unit) => !unit.isUndead
//  };
//
//  void fromList(List<String> targetList) {
//    for (String group in targetList) {
//      _parseTarget(group);
//    }
//  }
//
//  bool match(Unit invoker, Field field) {
//    if (field.units.length == 0) {
//      return empty != null;
//    }
//    return selectMatchingUnit(invoker, field) != null;
//  }
//
//  Unit selectMatchingUnit(Unit invoker, Field field) {
//    List<Unit> alives = field.alivesOnField();
//    if (alives.contains(invoker)) {
//      if (alives.length > 1) {
//        if (me != null) {
//          if (_matchUnit([invoker], me) != null) return invoker;
//        }
//        alives.remove(invoker);
//      } else {
//        return _matchUnit([invoker], me);
//      }
//    }
//    if (!alives.isEmpty) {
//      Unit firstUnit = alives.first;
//      if (firstUnit.player.id == invoker.player.id) {
//        return _matchUnit(alives, ally);
//      } else {
//        if (firstUnit.player.team == invoker.player.team) {
//          return _matchUnit(alives, team);
//        } else {
//          return _matchUnit(alives, enemy);
//        }
//      }
//    }
//    List<Unit> corpses = field.deathsOnField();
//    if (!corpses.isEmpty) {
//      return _matchUnit(corpses, corpse);
//    }
//    return null;
//  }
//  Iterable<Unit> selectMatchingUnits(Unit invoker, Field field) {
//    List<Unit> alives = field.alivesOnField();
//    if (alives.contains(invoker)) {
//      if (alives.length > 1) {
//        if (me != null) {
//          Unit selectedMe = _matchUnit([invoker], me);
//          alives.remove(invoker);
//          List<Unit> allyList = _matchUnits(alives, ally);
//          if(selectedMe==null) return allyList;
//          if(allyList==null) return [invoker];
//          return allyList..add(invoker);
//        }
//      } else {
//        return _matchUnits([invoker], me);
//      }
//    }
//    if (!alives.isEmpty) {
//      Unit firstUnit = alives.first;
//      if (firstUnit.player == invoker.player) {
//        return _matchUnits(alives, ally);
//      } else {
//        if (firstUnit.player.team == invoker.player.team) {
//          return _matchUnits(alives, team);
//        } else {
//          return _matchUnits(alives, enemy);
//        }
//      }
//    }
//    List<Unit> corpses = field.deathsOnField();
//    if (!corpses.isEmpty) {
//      return _matchUnits(corpses, corpse);
//    }
//    return null;
//  }
//
//  Unit _matchUnit(List<Unit> units, List<String> modificators) {
//    if (modificators == null) return null;
//    if (modificators.length == 0) return units.first;
//    return units.firstWhere((Unit unit) {
//      return modificators.every((String modificator) => checkUnits[modificator](unit));
//    });
//  }
//  Iterable<Unit> _matchUnits(List<Unit> units, List<String> modificators) {
//    if (modificators == null) return null;
//    if (modificators.length == 0) return units;
//    return units.where((Unit unit) {
//      return modificators.every((String modificator) => checkUnits[modificator](unit));
//    });
//  }
//
//  void _parseTarget(String group) {
//    List<String> parts = group.split("-");
//    String mainTarget;
//    List<String> others = [];
//    for (var i = 0; i < parts.length; i++) {
//      var part = parts[i];
//      if (TARGETS.contains(part)) {
//        mainTarget = part;
//        continue;
//      }
//      if (!MODIFICATORS.contains(part)) {
//        throw "Unknown TargetModificator: $part";
//      }
//      others.add(part);
//    }
//    switch (mainTarget) {
//      case TARGET_ME:
//        me = others;
//        return;
//      case TARGET_ALLY:
//        ally = others;
//        return;
//      case TARGET_TEAM:
//        team = others;
//        return;
//      case TARGET_ENEMY:
//        enemy = others;
//        return;
//      case TARGET_CORPSE:
//        corpse = others;
//        return;
//      case TARGET_EMPTY:
//        empty = others;
//        return;
//      default:
//        throw "Unknown MainTarget: $mainTarget";
//    }
//  }
//
//  List<String> toList() {
//    List<String> result = [];
//    _export("me", me, result);
//    _export("empty", empty, result);
//    _export("corpse", corpse, result);
//    _export("ally", ally, result);
//    _export("team", team, result);
//    _export("enemy", team, result);
//    return result;
//  }
//
//  static void _export(String name, List<String> modificators, List<String> result) {
//    if (modificators == null) return;
//    if (modificators.length == 0) {
//      result.add(name);
//      return;
//    }
//    result.add("$name-${modificators.join("-")}");
//  }
//}
//
//typedef bool CheckUnit(Unit unit);
