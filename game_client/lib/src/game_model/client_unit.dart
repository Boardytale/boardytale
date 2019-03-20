part of client_model;

class ClientUnit extends shared.Unit {
  ClientUnit(shared.UnitCreateOrUpdateAction action, Map<String, shared.Field> fields,
      Map<String, shared.Player> players, Map<String, shared.UnitType> types)
      : super(createClientAbilityList, action, fields, players, types);

  shared.Ability getAbility(shared.Track track, bool shift, bool alt, bool ctrl) {
    List<shared.Ability> possibles = abilities.toList();
    possibles..removeWhere((shared.Ability ability){
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

  List<String> whyNoAbility(shared.Track track) {
    return abilities
        .map((shared.Ability ability) => "${ability.name}: ${ability.validate(this, track)}")
        .toList(growable: false);
  }
}
