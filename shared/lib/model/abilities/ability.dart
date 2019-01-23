part of model;

@Typescript()
@JsonSerializable()
class AbilitiesEnvelope {
  @TypescriptOptional()
  MoveAbilityEnvelope move;

  @TypescriptOptional()
  AttackAbilityEnvelope attack;

  static AbilitiesEnvelope fromJson(Map json){
    return _$AbilitiesEnvelopeFromJson(json);
  }

  Map toJson(){
    return _$AbilitiesEnvelopeToJson(this);
  }
}

@Typescript()
enum Targets {
  @JsonValue('me')
  me,
  @JsonValue('own')
  own,
  @JsonValue('ally')
  ally,
  @JsonValue('enemy')
  enemy,
  @JsonValue('corpse')
  corpse,
  @JsonValue('empty')
  empty,
}

@Typescript()
enum TargetModificators {
  @JsonValue('wounded')
  wounded,
  @JsonValue('notUndead')
  notUndead,
  @JsonValue('undead')
  undead,
}

@Typescript()
abstract class Ability {
  String name;
  String image;
  Map<Targets, List<TargetModificators>> targets;
  static const TRIGGER_MINE_TURN_START = "mine_turn_start";
  static const REACH_MOVE = "reachMove";
  static const REACH_HAND = "reachHand";
  static const REACH_ARROW = "reachArrow";
  static const REACH_CONJURATION = "reachConjuration";
  @TypescriptSkip()
  @TypescriptOptional()
  String get reach;
  Unit invoker;

  bool validate(Unit invoker, Track track){
    throw "not implemented";
  }

  void setInvoker(Unit invoker){
    this.invoker = invoker;
  }
}

//
//abstract class Ability {
//  static const TRIGGER_MINE_TURN_START = "mine_turn_start";
//  static const REACH_MOVE = "reachMove";
//  static const REACH_HAND = "reachHand";
//  static const REACH_ARROW = "reachArrow";
//  static const REACH_CONJURATION = "reachConjuration";
//  int actions = 1;
//  String trigger;
//  String name;
//  String img;
//  String imageId;
//  Targets targets;
//  List<int> _attack;
//  @TypescriptOptional()
//  int range;
//
////  List<String> target = [];
//  String get reach;
//
//  Map<String, dynamic> _abilityData;
//
////  static Ability createAbility(Map<String, dynamic> data) {
////    String abilityClass = data["class"] as String;
////    switch (abilityClass) {
////      case "move":
////        return new MoveAbility()..fromMap(data);
////      case "attack":
////        return new AttackAbility()..fromMap(data);
////      case "shoot":
////        return new ShootAbility()..fromMap(data);
////      case "heal":
////        return new HealAbility()..fromMap(data);
////      case "revive":
////        return new ReviveAbility()..fromMap(data);
////      case "hand_heal":
////        return new HandHealAbility()..fromMap(data);
////      case "boost":
////        return new BoostAbility()..fromMap(data);
////      case "linked_move":
////        return new LinkedMoveAbility()..fromMap(data);
////      case "step_shoot":
////        return new StepShootAbility()..fromMap(data);
////      case "light":
////        return new LightAbility()..fromMap(data);
////      case "summon":
////        return new SummonAbility()..fromMap(data);
////      case "dismiss":
////        return new DismissAbility()..fromMap(data);
////      case "raise":
////        return new RaiseAbility()..fromMap(data);
////      case "teleport":
////        return new TeleportAbility()..fromMap(data);
////      case "dark_shoot":
////        return new DarkShootAbility()..fromMap(data);
////      case "regeneration":
////        return new RegenerationAbility()..fromMap(data);
////      case "change_type":
////        return new ChangeTypeAbility()..fromMap(data);
////    }
////    throw "ability $abilityClass $data not implemented";
////  }
//
//  int getRange(Unit invoker) {
//    if (_range != null) return _range;
//    return invoker.range;
//  }
//
//  List<int> getAttack(Unit invoker) {
//    if (_attack != null) return _attack;
//    return invoker.attack;
//  }
//
//  Alea prepareAlea(Unit invoker) => new Alea(getAttack(invoker));
//
//  String validate(Unit unit, Track track) {
//    if (unit.actions < actions) return "too few actions";
//    if (reach == REACH_ARROW || reach == REACH_CONJURATION) {
//      if (unit.far > 0) {
//        return "unit already moved too far";
//      }
//      if (_range == null) {
//        if (track.length > unit.range) return "out of range of unit";
//      } else {
//        if (track.length > _range) return "out of range of ability";
//      }
//    }
//    if (reach == REACH_HAND || reach == REACH_MOVE) {
//      if (unit.steps < track.length) return "too few steps";
//      if (reach == REACH_MOVE) {
//        if (!track.isFreeWay(unit.player)) return "no free way";
//      } else {
//        if (!track.isHandMove(unit.player)) return "no free way";
//      }
//    }
//
//    //match target
//    if (!targets.match(unit, track.last)) {
//      return "no correct target";
//    }
//    return null;
//  }
//
//  void resetProperties() {}
//
//  void setDefaults(Map defaults) {}
//}

@Typescript()
enum AbilityNames {
  @JsonValue('move')
  move,
  @JsonValue('attack')
  attack,
  @JsonValue('shoot')
  shoot,
  @JsonValue('heal')
  heal,
  @JsonValue('revive')
  revive,
  @JsonValue('hand_heal')
  hand_heal,
  @JsonValue('boost')
  boost,
  @JsonValue('linked_move')
  linked_move,
  @JsonValue('step_shoot')
  step_shoot,
  @JsonValue('light')
  light,
  @JsonValue('summon')
  summon,
  @JsonValue('dismiss')
  dismiss,
  @JsonValue('change_type')
  change_type,
  @JsonValue('regeneration')
  regeneration,
  @JsonValue('dark_shoot')
  dark_shoot,
  @JsonValue('teleport')
  teleport,
  @JsonValue('raise')
  raise
}
