library tales_compiler;

import 'dart:convert';
import 'package:boardytale_commons/model/model.dart';

part 'assets_pack.dart';

part 'load_images.dart';

Map<String, Tale> getTalesFromFileMap(Map fileMap,ClassGenerator generator) {
  return loadTales(fileMap, getUnitsFromFileMap(fileMap,generator),generator);
}

Map<String, UnitType> getUnitsFromFileMap(Map fileMap,ClassGenerator generator) {
  Map<String, Image> images = loadImages(fileMap,generator);
  Map abilities = loadAbilities(JSON.decode(fileMap["abilities.json"]));
  Map races = loadRaces(JSON.decode(fileMap["races.json"]),generator);
  return loadUnits(
      fileMap["unitTypes"].values.toList(), images, abilities, races,generator);
}

Map<String, Race> loadRaces(List racesData,ClassGenerator generator) {
  Map<String, Race> races = {};
  for (Map race in racesData) {
    races[race["id"]] = generator.race()
      ..fromMap(race);
  }
  return races;
}

Map<String,Tale> loadTales(Map<String, dynamic> fileMap, Map<String, UnitType> units,ClassGenerator generator) {
  Map talesData = fileMap["tales"];
  Map<String, Tale> tales = {};
  talesData.forEach((dynamic k, dynamic v) {
    Tale tale = generator.tale();
    tale = loadTaleFromAssets(JSON.decode(v), units, tale,generator);
    tales[tale.id] = tale;
  });
  return tales;
}

Tale loadTaleFromAssets(Map taleData, Map<String, UnitType> units, Tale tale,ClassGenerator generator) {
  tale.fromMap(taleData,generator);
  int unitId = 0;
  for (Map m in tale.unitData) {
    String typeId = m["type"].toString();
    if(!units.containsKey(typeId)) throw "Type $typeId is not defined";
    Unit unit = generator.unit(unitId++, units[typeId])
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
    Map<String, Ability> abilities, Map races,ClassGenerator generator) {
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
    UnitType unitType = generator.unitType()..fromMap(unit);
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
