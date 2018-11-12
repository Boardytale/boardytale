part of boardytale.server.abilities;

class HealAbility extends commonLib.HealAbility implements ServerAbility {
  @override
  String perform(Unit invoker, commonLib.Track track) {
    commonLib.Alea alea = prepareAlea(invoker);

    Unit target = targets.selectMatchingUnit(invoker, track.last);
    if(target!=null){
      return target.heal(alea).toString();
    }
    return "no target";
  }
}
