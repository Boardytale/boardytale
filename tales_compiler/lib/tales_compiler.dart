library tales_compiler;

import 'dart:convert';
import 'package:image/image.dart' as image_lib;
import 'package:boardytale_commons/model/model.dart';

part 'assets_pack.dart';
part 'load_images.dart';

Map<int, Tale> getTalesFromFileMap(Map fileMap) {
  return loadTales(fileMap, getUnitsFromFileMap(fileMap));
}

Map<int, UnitType> getUnitsFromFileMap(Map fileMap) {
  Map<int, Image> images = loadImages(fileMap);
  Map abilities = loadAbilities(fileMap);
  Map races = loadRaces(fileMap);
  return loadUnits(fileMap, images, abilities, races);
}

Map loadRaces(Map<String, dynamic> fileMap) {
  String racesString = fileMap["races.json"];
  List racesData = JSON.decode(racesString);
  Map<String, Race> races = {};
  for (Map race in racesData) {
    races[race["id"]] = new Race()
      ..fromMap(race);
  }
  return races;
}

Map loadTales(Map<String, dynamic> fileMap, Map<int, UnitType> units) {
  Map talesData = fileMap["tales"];
  Map<int, Tale> tales = {};
  talesData.forEach((k, v) {
    Tale tale = new Tale()
      ..fromMap(JSON.decode(v));
    tales[tale.id] = tale;
    int unitId = 0;
    for (Map m in tale.unitData) {
      Unit unit = new Unit(unitId++, units[m["type"]])
        ..fromMap(m);
      tale.units[unit.id] = unit;
    }
  });
  return tales;
}

Map loadAbilities(Map<String, dynamic> fileMap) {
  Map<String, Ability> abilities = {};
  List abilitiesList = JSON.decode(fileMap["abilities.json"]);
  for (Map abilityData in abilitiesList) {
    Ability ability = Ability.createAbility(abilityData);
    abilities[ability.className] = ability;
  }
  return abilities;
}

Map<int, UnitType> loadUnits(Map<String, dynamic> fileMap, Map images,
    Map<String, Ability> abilities, Map races) {
  Map unitTypesMap = fileMap["unitTypes"];
  Map<int, UnitType> unitTypes = {};
  unitTypesMap.forEach((k, v) {
    Map unit;
    if (v is Map) {
      unit = v;
    } else if (v is String) {
      unit = JSON.decode(v);
    } else {
      throw "unsupported unit format";
    }
    UnitType unitType = new UnitType();
    unitType.fromMap(unit);
    unitType.image = images[unitType.imageId];
    unitTypes[unitType.id] = unitType;
    for (Map abilityData in unitType.abilitiesData) {
      unitType.abilities.add(
          abilities[abilityData["class"]].createAbilityWithUnitData(
              abilityData));
    }
    unitType.race = races[unitType.raceId];
  });
  return unitTypes;
}
