part of boardytale.client.abilities;

class AttackAbility extends commonLib.AttackAbilityEnvelope implements ClientAbility{

  @override
  void show(commonLib.Unit invoker,commonLib.Track track) {
    // TODO: implement perform
  }

  bool validate(commonLib.Unit invoker,commonLib.Track track){
    throw "not implemented";
  }

  @override
  String image;

  @override
  String name;

  @override
  Map<commonLib.Targets, List<commonLib.TargetModificators>> targets;

  @override
  // TODO: implement reach
  String get reach => null;

  @override
  commonLib.Unit invoker;

  @override
  void setInvoker(commonLib.Unit invoker) {
    // TODO: implement setInvoker
  }

}
