part of tales_compiler;

Map createAssetsPack(Tale tale) {
  Map out = {};
  Map<int, Map> imagesOut = new Map<int, Map>();
  Map<String, Map> abilitiesOut = new Map<String, Map>();
  Map<String, Map> racesOut = new Map<String, Map>();
  Map<int, Map> unitsOut = new Map<int, Map>();

  tale.units.forEach((id, Unit unit) {
    Image image = unit.type.image;
    if (!imagesOut.containsKey(image.id)) {
      imagesOut[image.id] = image.toMap();
    }
    for(Ability ability in unit.type.abilities){
      if(!abilitiesOut.containsKey(ability.type.name)){
        abilitiesOut[ability.type.name] = ability.type.toMap();
      }
    }
    if(!racesOut.containsKey(unit.type.race.id)){
      racesOut[unit.type.race.id] = unit.type.race.toMap();
    }
    if(!unitsOut.containsKey(unit.type.id)){
      unitsOut[unit.type.id] = unit.type.toMap();
    }
  });
  out["tale"] = tale.toMap();
  out["units"] = unitsOut.values.toList();
  out["abilities"] = abilitiesOut;
  out["races"] = racesOut;
  out["images"] = imagesOut.values.toList();
  return out;
}

