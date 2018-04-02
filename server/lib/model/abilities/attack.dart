part of boardytale.server.abilities;

class AttackAbility extends commonLib.AttackAbility implements ServerAbility {
  @override
  String perform(Unit invoker, commonLib.Track track) {
    if(track.length>=1){
      commonLib.Track shortened = new commonLib.Track.shorten(track,1);
      invoker.move(shortened);
    }
    commonLib.Alea alea = prepareAlea(invoker);
    targets.selectMatchingUnits(invoker, track.last).forEach((commonLib.Unit unit) {
      unit.harm(alea);
    });
    return alea.toString();
  }
}
