part of boardytale.client.abilities;

class ClientAttackAbility implements ClientAbility {
  @override
  void show(shared.Unit invoker, shared.Track track) {
    // TODO: implement perform
  }

  bool validate(shared.Unit invoker, shared.Track track) {
    
    return false;
  }

  @override
  String image;

  /**
   *  use null to use invoker attack
   *  use 6 expressions separated by space
   *  rules are aligned with range
   *  example: "0 0 1 +1 +2 -1"
   *  every value above 9 will be 9
   */
  String attack;

  /**
   *  use null to use invoker range
   *  use "+1" "-1" to change invoker original
   *  use "4" to set specific range
   *  use "0" for face-to-face units
   *  any range above 7 will be set to 7
   */
  String range;

  @override
  Map<shared.Targets, List<shared.TargetModificators>> targets;

  @override
  // TODO: implement reach
  String get reach => null;

  @override
  shared.Unit invoker;

  @override
  void setInvoker(shared.Unit invoker) {
    // TODO: implement setInvoker
  }

  @override
  shared.AbilityName name;

  fromEnvelope(shared.AttackAbilityEnvelope envelope) {
    if(envelope.attack != null) {
      attack = envelope.attack;
    }
    if(envelope.range != null){
      range = envelope.range;
    }
  }
}
