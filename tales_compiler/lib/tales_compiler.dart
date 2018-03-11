library tales_compiler;

import 'dart:convert';
import 'package:boardytale_commons/model/model.dart';

part 'assets_pack.dart';

part 'load_images.dart';

Map<String, Tale> getTalesFromFileMap(Map fileMap) {
  return loadTales(fileMap, getUnitsFromFileMap(fileMap));
}

Map<String, UnitType> getUnitsFromFileMap(Map fileMap) {
  Map<String, Image> images = loadImages(fileMap);
  Map abilities = loadAbilities(JSON.decode(fileMap["abilities.json"]));
  Map races = loadRaces(JSON.decode(fileMap["races.json"]));
  return loadUnits(
      fileMap["unitTypes"].values.toList(), images, abilities, races);
}

Map<String, Race> loadRaces(List racesData) {
  Map<String, Race> races = {};
  for (Map race in racesData) {
    races[race["id"]] = new Race()
      ..fromMap(race);
  }
  return races;
}

Map<String,Tale> loadTales(Map<String, dynamic> fileMap, Map<String, UnitType> units) {
  Map talesData = fileMap["tales"];
  Map<String, Tale> tales = {};
  talesData.forEach((dynamic k, dynamic v) {
    Tale tale = new Tale();
    tale = loadTaleFromAssets(JSON.decode(v), units, tale);
    tales[tale.id] = tale;
  });
  return tales;
}

Tale loadTaleFromAssets(Map taleData, Map<String, UnitType> units, Tale tale) {
  tale.fromMap(taleData);
  int unitId = 0;
  for (Map m in tale.unitData) {
    String typeId = m["type"].toString();
    if(!units.containsKey(typeId)) throw "Type $typeId is not defined";
    Unit unit = new Unit(unitId++, units[typeId])
      ..fromMap(m);
    tale.units[unit.id] = unit;
  }
  return tale;
}

Map loadAbilities(List abilitiesList) {
  Map<String, Ability> abilities = {};
  for (Map abilityData in abilitiesList) {
    Ability ability = Ability.createAbility(abilityData);
    abilities[ability.className] = ability;
  }
  return abilities;
}

Map<String, UnitType> loadUnits(List<dynamic> unitTypesList, Map images,
    Map<String, Ability> abilities, Map races) {
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
    UnitType unitType = new UnitType();
    unitType.fromMap(unit);
    unitType.image = images[unitType.imageId];
    if (unitType.bigImageId != null) {
      unitType.bigImage = images[unitType.bigImageId];
    }
    if (unitType.iconId != null) {
      unitType.iconImage = images[unitType.iconId];
    }
    unitTypes[unitType.id] = unitType;
    for (Map abilityData in unitType.abilitiesData) {
      unitType.abilities.add(
          abilities[abilityData["class"]].createAbilityWithUnitData(
              abilityData));
    }
    unitType.race = races[unitType.raceId];
  }
  return unitTypes;
}
