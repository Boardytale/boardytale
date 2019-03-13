part of client_model;

class ClientUnit extends shared.Unit {
  shared.AiGroup aiGroup;
  ClientUnit() : super(createClientAbilityList);

  int getStagePlayerColor(){
    if(player != null){
      return player.color;
    }
    var color = ColorParser(aiGroup.color);
    return int.parse("0xFF${color.red.toRadixString(16)}${color.green.toRadixString(16)}${color.blue.toRadixString(16)}");
  }

  get handlerId => (player != null?player.id:aiGroupId).substring(0,1);

  shared.Ability getAbility(
      shared.Track track, bool shift, bool alt, bool ctrl) {
    List<shared.Ability> possibles = abilities.toList();
    possibles
      ..removeWhere(
          (shared.Ability ability) => !ability.validate(this, track));

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
        .map((shared.Ability ability) =>
            "${ability.name}: ${ability.validate(this, track)}")
        .toList(growable: false);
  }
}
