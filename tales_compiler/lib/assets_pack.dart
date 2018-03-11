part of tales_compiler;

class TaleAssetsPack{
  static Map pack(Tale tale){
    Map out = {};
    Map<String, Map> imagesOut = new Map<String, Map>();
    Map<String, Map> abilitiesOut = new Map<String, Map>();
    Map<String, Map> racesOut = new Map<String, Map>();
    Map<String, Map> unitsOut = new Map<String, Map>();

    tale.units.forEach((id, Unit unit) {
      Image image = unit.type.image;
      if (!imagesOut.containsKey(image.id)) {
        imagesOut[image.id] = image.toMap();
      }

      image = unit.type.bigImage;
      if (image != null && !imagesOut.containsKey(image.id)) {
        imagesOut[image.id] = image.toMap();
      }

      image = unit.type.iconImage;
      if (image != null && !imagesOut.containsKey(image.id)) {
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
    out["abilities"] = abilitiesOut.values.toList();
    out["races"] = racesOut.values.toList();
    out["images"] = imagesOut.values.toList();
    return out;
  }

  static Tale unpack(Map pack, Tale tale, ClassGenerator generator){
    Map<String, UnitType> unitTypes = getUnitsFromPack(pack,generator);
    loadTaleFromAssets(pack["tale"], unitTypes, tale,generator);
    return tale;
  }

  static Map<String, UnitType> getUnitsFromPack(Map pack,ClassGenerator generator) {
    Map<String, Image> images = loadImagesFromPack(pack,generator);
    Map abilities = loadAbilities(pack["abilities"]);
    Map races = loadRaces(pack["races"],generator);
    return loadUnits(pack["units"], images, abilities, races,generator);
  }

  static Map<String, Image> loadImagesFromPack(Map pack,ClassGenerator generator){
    Map<String, Image> out = {};
     for(Map imageData in pack["images"]){
       Image image = generator.image()..fromMap(imageData);
       out[image.id] = image;
     }
    return out;
  }
}
