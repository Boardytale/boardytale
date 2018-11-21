part of boardytale.server.abilities;

class MoveAbility extends commonLib.MoveAbility implements ServerAbility{

  @override
  String perform(Unit invoker,commonLib.Track track) {
    invoker.move(track);
    return invoker.far.toString();
  }
}
