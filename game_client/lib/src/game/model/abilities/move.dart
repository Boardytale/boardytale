part of boardytale.client.abilities;

class MoveAbility extends commonLib.MoveAbilityEnvelope
    implements ClientAbility {
  @override
  void show(commonLib.Unit invoker, commonLib.Track track) {
    invoker.move(track);
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
  bool validate(commonLib.Unit invoker, commonLib.Track track) {
    // TODO: implement validate
    return null;
  }

  @override
  commonLib.Unit invoker;

  @override
  void setInvoker(commonLib.Unit invoker) {
    // TODO: implement setInvoker
  }
}
