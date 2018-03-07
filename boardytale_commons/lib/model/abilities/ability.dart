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
  String className;
  String img;
  String imageId;
  List<String> target = [];
  Ability type;

  static Ability createAbility(Map<String,dynamic> data){
    String abilityClass = data["class"] as String;
    switch(abilityClass){
      case "move": return new MoveAbility()..fromMap(data);
      case "attack": return new AttackAbility()..fromMap(data);
      case "shoot": return new ShootAbility()..fromMap(data);
      case "heal": return new HealAbility()..fromMap(data);
      case "revive": return new ReviveAbility()..fromMap(data);
      case "hand_heal": return new HandHealAbility()..fromMap(data);
      case "boost": return new BoostAbility()..fromMap(data);
      case "linked_move": return new LinkedMoveAbility()..fromMap(data);
      case "step_shoot": return new StepShootAbility()..fromMap(data);
      case "light": return new LightAbility()..fromMap(data);
      case "summon": return new SummonAbility()..fromMap(data);
      case "dismiss": return new DismissAbility()..fromMap(data);
      case "raise": return new RaiseAbility()..fromMap(data);
      case "teleport": return new TeleportAbility()..fromMap(data);
      case "dark_shoot": return new DarkShootAbility()..fromMap(data);
      case "regeneration": return new RegenerationAbility()..fromMap(data);
      case "change_type": return new ChangeTypeAbility()..fromMap(data);
    }
    throw "ability $abilityClass $data not implemented";
  }
  
  void setInvoker(Unit unit){
    invoker = unit;
  }
  
  void show(Track track);
  void perform(Track track);
  void resetProperties(){
    
  }

  void setDefaults(Map defaults){}

  Ability createAbilityWithUnitData(Map<String,dynamic> unitAbilityData){
    Ability abilityClone = clone();
    abilityClone.type = this;
    abilityClone.fromMap(unitAbilityData);
    return abilityClone;
  }
  
  Ability clone();
  
  void fromMap(Map<String,dynamic> ability){
    name = ability["name"].toString().toLowerCase();
    imageId = ability["imageId"] as String;
    target = ability["target"] as List<String>;
    className = ability["class"] as String;
  }


  Map<String,dynamic> toMap(){
    Map<String,dynamic> out = <String,dynamic>{};
    out["name"] = name;
    out["img"] = img;
    out["target"] = target;
    out["class"] = className;
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
