part of model;

abstract class Ability{
  static const TARGET_ENEMY = "enemy";
  static const TARGET_FIELD = "field";
  static const TARGET_ALLY = "ally";
  static const TARGET_CORPSE = "corpse";
  static const TARGET_ME = "me";
  static const TARGET_WOUNDED_ALLY = "wonundedAlly";
  static const TARGET_WOUNDED_ENEMY = "woundedEnemy";
  static const TARGET_NOT_UNDEAD_CORPSE = "not_undead_corpse";
  static const TRIGGER_MINE_TURN_START = "mine_turn_start";
  Unit invoker;
  int actions = 1;
  String trigger;

  int range;
  String name;
  String id;
  String img;
  List<String> target = [];
  
  void setInvoker(Unit unit){
    invoker = unit;
  }
  
  void show(Track track);
  void perform(Track track);
  void resetProperties(){
    
  }

  void setDefaults(Map defaults){}
  
  Ability clone();
  
  void fromJson(Map ability){
    id = ability["class"].toString().toLowerCase();
    img = ability["img"];
    target = ability["target"];
  }


  Map toJson(){
    Map out = {};
    out["name"] = name;
    return out;
  }
  /// steps needed to next
  int getPossiblesSteps(){
    return 0;
  }

  bool freeWayNeeded(){
    return true;
  }
}

Ability getAbilityByType(String type){
  switch(type){
    case "move": return new MoveAbility();
    case "attack": return new AttackAbility();
    case "shoot": return new ShootAbility();
    case "heal": return new HealAbility();
    case "revive": return new ReviveAbility();
    case "hand_heal": return new HandHealAbility();
    case "boost": return new BoostAbility();
    case "linked_move": return new LinkedMoveAbility();
    case "step_shoot": return new StepShootAbility();
    case "light": return new LightAbility();
    case "summon": return new SummonAbility();
    case "fly": return new FlyAbility();
    case "raise": return new RaiseAbility();
    case "teleport": return new TeleportAbility();
    case "dark_shoot": return new DarkShootAbility();
    case "regeneration": return new RegenerationAbility();
    case "change_type": return new ChangeTypeAbility();
  }
  return null;
}