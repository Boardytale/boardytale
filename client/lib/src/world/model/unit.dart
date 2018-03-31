part of client_model;

class Unit extends commonModel.Unit {
  Unit(int id) : super(id);

  commonModel.Ability getAbility(commonModel.Track track, bool shift, bool alt, bool ctrl) {
    List<commonModel.Ability> possibles = abilities.toList();
    for (commonModel.Ability ability in possibles) {
      if (ability.validate(this, track) != null) {
        possibles.remove(ability);
      }
    }

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
}
