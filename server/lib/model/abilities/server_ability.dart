part of boardytale.server.abilities;

abstract class ServerAbility extends commonLib.Ability{
  static ServerAbility createAbility(Map<String, dynamic> data) {
    String abilityClass = data["class"] as String;
    switch (abilityClass) {
      case "move":
        return new MoveAbility()..fromMap(data);
      case "attack":
        return new AttackAbility()..fromMap(data);
      case "shoot":
        return new ShootAbility()..fromMap(data);
//      case "heal":
//        return new HealAbility()..fromMap(data);
//      case "revive":
//        return new ReviveAbility()..fromMap(data);
//      case "hand_heal":
//        return new HandHealAbility()..fromMap(data);
//      case "boost":
//        return new BoostAbility()..fromMap(data);
//      case "linked_move":
//        return new LinkedMoveAbility()..fromMap(data);
//      case "step_shoot":
//        return new StepShootAbility()..fromMap(data);
//      case "light":
//        return new LightAbility()..fromMap(data);
//      case "summon":
//        return new SummonAbility()..fromMap(data);
//      case "dismiss":
//        return new DismissAbility()..fromMap(data);
//      case "raise":
//        return new RaiseAbility()..fromMap(data);
//      case "teleport":
//        return new TeleportAbility()..fromMap(data);
//      case "dark_shoot":
//        return new DarkShootAbility()..fromMap(data);
//      case "regeneration":
//        return new RegenerationAbility()..fromMap(data);
//      case "change_type":
//        return new ChangeTypeAbility()..fromMap(data);
    }
    throw "ability $abilityClass $data not implemented";
  }

  void perform(Unit invoker,commonLib.Track track);
}