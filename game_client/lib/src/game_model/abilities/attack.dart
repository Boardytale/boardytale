part of boardytale.client.abilities;

class AttackAbility extends shared.AttackAbilityEnvelope
    implements ClientAbility {
  @override
  void show(shared.Unit invoker, shared.Track track) {
    // TODO: implement perform
  }

  bool validate(shared.Unit invoker, shared.Track track) {
    throw "not implemented";
  }

  @override
  String image;

  @override
  String name;

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
}
