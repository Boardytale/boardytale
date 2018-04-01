part of boardytale.server.abilities;

class AttackAbility extends commonLib.AttackAbility implements ServerAbility {
  @override
  String perform(Unit invoker, commonLib.Track track) {
    commonLib.Alea alea = new commonLib.Alea(invoker.attack);
    int damage = 0;
    track.last.units.forEach((commonLib.Unit unit) {
      damage += unit.harm(alea);
    });
    return damage.toString();
  }
}
