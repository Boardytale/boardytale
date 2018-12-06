part of boardytale.client.abilities;

class MoveAbility extends commonLib.MoveAbility implements ClientAbility{

  @override
  void show(commonLib.Unit invoker,commonLib.Track track) {
    invoker.move(track);
  }
}
