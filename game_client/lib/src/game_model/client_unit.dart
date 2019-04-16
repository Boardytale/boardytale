part of client_model;

class ClientUnit extends core.Unit {
  ClientUnit(core.UnitCreateOrUpdateAction action, Map<String, core.Field> fields,
      Map<String, core.Player> players, Map<String, core.UnitType> types)
      : super(createClientAbilityList, action, fields, players, types);

  core.Ability getAbility(core.Track track, bool shift, bool alt, bool ctrl) {
    List<core.Ability> possibles = abilities.toList();
    possibles..removeWhere((core.Ability ability){
      return !ability.validate(this, track);
    });

    int used = 0;
    if (possibles.isEmpty) {
      return null;
    } else if (possibles.length > 0) {
      if (possibles.length == 2 && (shift || alt || ctrl))
        used = 1;
      else if (possibles.length == 3) {
        if (ctrl)
          used = 1;
        else if (shift || alt) used = 2;
      } else if (possibles.length > 3) {
        if (ctrl)
          used = 1;
        else if (shift)
          used = 2;
        else if (alt) used = 3;
      }
    }
    return possibles[used];
  }

  List<String> whyNoAbility(core.Track track) {
    return abilities
        .map((core.Ability ability) => "${ability.name}: ${ability.validate(this, track)}")
        .toList(growable: false);
  }
}
