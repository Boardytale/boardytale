part of boardytale.server.abilities;

class MoveAbility extends commonLib.MoveAbility implements ServerAbility{

  @override
  void perform(Unit invoker,commonLib.Track track) {
    invoker.move(track);
  }
}
