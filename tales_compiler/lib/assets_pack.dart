part of tales_compiler;

class TaleAssetsPack {
  static Map pack(Tale tale, Resources allResources) {
    Map out = {};
    Map<String, Map> imagesOut = new Map<String, Map>();
    Map<String, Map> abilitiesOut = new Map<String, Map>();
    Map<String, Map> racesOut = new Map<String, Map>();
    Map<String, Map> unitsOut = new Map<String, Map>();

    tale.units.forEach((id, Unit unit) {
      Image image = unit.type.image;
      if (!imagesOut.containsKey(image.innerToken)) {
        imagesOut[image.innerToken] = image.toMap();
      }

      image = unit.type.bigImage;
      if (image != null && !imagesOut.containsKey(image.innerToken)) {
        imagesOut[image.innerToken] = image.toMap();
      }

      image = unit.type.iconImage;
      if (image != null && !imagesOut.containsKey(image.innerToken)) {
        imagesOut[image.innerToken] = image.toMap();
      }

//      for (Ability ability in unit.type.abilities) {
//        if (!abilitiesOut.containsKey(ability.type.name)) {
//          abilitiesOut[ability.type.name] = ability.type.toMap();
//        }
//      }
      if (!racesOut.containsKey(unit.type.race.innerToken)) {
        racesOut[unit.type.race.innerToken] = unit.type.race.toMap();
      }
      if (!unitsOut.containsKey(unit.type.innerToken)) {
        unitsOut[unit.type.innerToken] = unit.type.toMap();
      }
    });
    out["tale"] = tale.toMap();
    out["unitTypes"] = unitsOut.values.toList();
    out["abilities"] = abilitiesOut.values.toList();
    out["races"] = racesOut.values.toList();
    out["images"] = imagesOut.values.toList();
    return out;
  }

  static Tale unpack(Map pack, InstanceGenerator generator) {
    Resources resources = generator.resources();
    resources.images = loadImages(pack["images"], generator);
    resources.abilities = loadAbilities(pack["abilities"],generator);
    resources.races = loadRaces(pack["races"], generator);
    resources.unitTypes= loadUnitsTypes(pack["unitTypes"], resources);
    Tale tale = loadTaleFromAssets(pack["tale"], resources);
    tale.resources=resources;
    return tale;
  }

  static Map<String, Image> loadImages(List<Map> imageDataList, InstanceGenerator generator) {
    Map<String, Image> out = {};
    for (Map imageData in imageDataList) {
      Image image = generator.image()..fromMap(imageData);
      out[image.innerToken] = image;
    }
    return out;
  }
}
