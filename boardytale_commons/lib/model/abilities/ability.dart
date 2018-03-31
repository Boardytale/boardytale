part of model;

abstract class Ability {
  static const TRIGGER_MINE_TURN_START = "mine_turn_start";

  static const REACH_MOVE = "reachMove";
  static const REACH_HAND = "reachHand";
  static const REACH_ARROW = "reachArrow";
  static const REACH_CONJURATION = "reachConjuration";

  int actions = 1;
  String trigger;
  int range;
  String name;
  String className;
  String img;
  String imageId;
  Targets targets;
//  List<String> target = [];
  String get reach;
  Map<String, dynamic> _abilityData;

  static Ability createAbility(Map<String, dynamic> data) {
    String abilityClass = data["class"] as String;
    switch (abilityClass) {
      case "move":
        return new MoveAbility()..fromMap(data);
      case "attack":
        return new AttackAbility()..fromMap(data);
      case "shoot":
        return new ShootAbility()..fromMap(data);
      case "heal":
        return new HealAbility()..fromMap(data);
      case "revive":
        return new ReviveAbility()..fromMap(data);
      case "hand_heal":
        return new HandHealAbility()..fromMap(data);
      case "boost":
        return new BoostAbility()..fromMap(data);
      case "linked_move":
        return new LinkedMoveAbility()..fromMap(data);
      case "step_shoot":
        return new StepShootAbility()..fromMap(data);
      case "light":
        return new LightAbility()..fromMap(data);
      case "summon":
        return new SummonAbility()..fromMap(data);
      case "dismiss":
        return new DismissAbility()..fromMap(data);
      case "raise":
        return new RaiseAbility()..fromMap(data);
      case "teleport":
        return new TeleportAbility()..fromMap(data);
      case "dark_shoot":
        return new DarkShootAbility()..fromMap(data);
      case "regeneration":
        return new RegenerationAbility()..fromMap(data);
      case "change_type":
        return new ChangeTypeAbility()..fromMap(data);
    }
    throw "ability $abilityClass $data not implemented";
  }

  String validate(Unit unit, Track track) {
    if (unit.actions < actions) return "too few actions";
    if (reach == REACH_ARROW || reach == REACH_CONJURATION) {
      if (unit.far > 0) {
        return "unit already moved too far";
      }
    }
    if (reach == REACH_HAND || reach == REACH_MOVE) {
      if (unit.steps < track.length) return "too few steps";
      if (reach == REACH_MOVE) {
        if (!track.isFreeWay(unit.player)) return "no free way";
      } else {
        if (!track.isHandMove(unit.player)) return "no free way";
      }
    }

    //match target
    if (!targets.match(unit, track)) {
      return "no correct target";
    }
    return null;
  }

  void resetProperties() {}

  void setDefaults(Map defaults) {}

  void fromMap(Map<String, dynamic> ability) {
    if (_abilityData == null) {
      _abilityData = ability;
    } else {
      _abilityData.addAll(ability);
    }
    name = ability["name"].toString().toLowerCase();
    imageId = ability["imageId"] as String;
    targets = new Targets()..fromList(ability["target"] as List<String>);
    className = ability["class"] as String;
  }

  Map<String, dynamic> toMap() {
    return _abilityData;
  }
}
