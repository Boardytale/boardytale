library tales_compiler;

import 'dart:convert';
import 'package:boardytale_commons/model/model.dart';

part 'assets_pack.dart';

part 'load_images.dart';

Resources getResourcesFromFileMap(Map fileMap, InstanceGenerator generator) {
  Resources resources = generator.resources();
  resources.images = loadImages(fileMap, generator);
  resources.abilities = loadAbilities(JSON.decode(fileMap["abilities.json"]));
  resources.races = loadRaces(JSON.decode(fileMap["races.json"]), generator);
  resources.unitTypes = loadUnitsTypes(fileMap["unitTypes"].values.toList(), resources);
  return resources;
}

Map<String, Race> loadRaces(List racesData, InstanceGenerator generator) {
  Map<String, Race> races = {};
  for (Map race in racesData) {
    races[race["id"]] = generator.race()..fromMap(race);
  }
  return races;
}

Map<String, Tale> loadTales(Map<String, dynamic> fileMap, Resources resources) {
  Map talesData = fileMap["tales"];
  Map<String, Tale> tales = {};
  talesData.forEach((dynamic k, dynamic v) {
    Tale tale = loadTaleFromAssets(JSON.decode(v), resources);
    tales[tale.id] = tale;
  });
  return tales;
}

Tale loadTaleFromAssets(Map taleData, Resources resources) {
  Tale tale = resources.generator.tale(resources)..fromMap(taleData);
  return tale;
}

Map<String, Ability> loadAbilities(List abilitiesList) {
  Map<String, Ability> abilities = {};
  for (Map abilityData in abilitiesList) {
    Ability ability = Ability.createAbility(abilityData);
    abilities[ability.className] = ability;
  }
  return abilities;
}

Map<String, UnitType> loadUnitsTypes(List<dynamic> unitTypesList, Resources resources) {
  Map<String, UnitType> unitTypes = {};
  for (dynamic unitData in unitTypesList) {
    Map unit;
    if (unitData is Map) {
      unit = unitData;
    } else if (unitData is String) {
      unit = JSON.decode(unitData);
    } else {
      throw "unsupported unit format";
    }
    UnitType unitType = resources.generator.unitType()..fromMap(unit);
    unitType.image = resources.images[unitType.imageId];
    if (unitType.bigImageId != null) {
      unitType.bigImage = resources.images[unitType.bigImageId];
    }
    if (unitType.iconId != null) {
      unitType.iconImage = resources.images[unitType.iconId];
    }
    unitTypes[unitType.id] = unitType;
    for (Map abilityData in unitType.abilitiesData) {
      unitType.abilities.add(resources.abilities[abilityData["class"]].createAbilityWithUnitData(abilityData));
    }
    unitType.race = resources.races[unitType.raceId];
  }
  return unitTypes;
}
