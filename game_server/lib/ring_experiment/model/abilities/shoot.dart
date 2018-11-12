part of boardytale.server.abilities;

class ShootAbility extends commonLib.ShootAbility implements ServerAbility {
  @override
  String perform(Unit invoker, commonLib.Track track) {
    commonLib.Alea alea = prepareAlea(invoker);
    targets.selectMatchingUnits(invoker, track.last).forEach((commonLib.Unit unit) {
      unit.harm(alea);
    });
    return alea.toString();
  }
}
