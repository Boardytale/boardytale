part of boardytale.client.abilities;

class MoveAbility extends shared.MoveAbilityEnvelope
    implements ClientAbility {
  @override
  void show(shared.Unit invoker, shared.Track track) {
    invoker.move(track);
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
  bool validate(shared.Unit invoker, shared.Track track) {
    // TODO: implement validate
    return null;
  }

  @override
  shared.Unit invoker;

  @override
  void setInvoker(shared.Unit invoker) {
    // TODO: implement setInvoker
  }
}
