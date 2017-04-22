import 'dart:convert';
import 'dart:io';
import 'package:io_utils/io_utils.dart';
import 'package:boardytale_commons/model/model.dart';

String pathToData = "../data";

void main(){
  Map fileMap = getFileMap(new Directory(pathToData));
  Map images = loadImages(fileMap);
  Map abilities = loadAbilities(fileMap);
  Map races = loadRaces(fileMap);
  Map units = loadUnits(fileMap, images, abilities, races);
  Map tale = loadTale(fileMap, units);
}

Map loadRaces(Map<String, dynamic> fileMap) {
  String racesString = fileMap["races.json"];
  List racesData = JSON.decode(racesString);
  Map<String, Race> races = {};
  for(Map race in racesData){
    races[race["name"]] = new Race()..fromMap(race);
  }
  return races;
}

Map loadTale(Map<String, dynamic> fileMap, Map units) {
  Map tales = fileMap["tales"];
}

Map loadAbilities(Map<String, dynamic> fileMap) {
  Map<String, Ability> abilities = {};
  List abilitiesList = JSON.decode(fileMap["abilities.json"]);
  for(Map abilityData in abilitiesList){
    Ability ability = Ability.createAbility(abilityData);
    abilities[ability.className] = ability;
  }
  return abilities;
}

Map loadUnits(Map<String, dynamic> fileMap, Map images, Map<String, Ability> abilities, Map races) {
  Map unitTypesMap = fileMap["unitTypes"];
  Map<int, UnitType> unitTypes = {};
  unitTypesMap.forEach((k,v){
    Map unit;
    if(v is Map){
      unit = v;
    }else if(v is String){
      unit = JSON.decode(v);
    }else{
      throw "unsupported unit format";
    }
    UnitType unitType = new UnitType();
    unitType.fromMap(unit);
    unitType.image = images[unitType.imageId];
    unitTypes[unitType.id] = unitType;
    for(Map abilityData in unitType.abilitiesData){
      unitType.abilities.add(abilities[abilityData["class"]].createAbilityWithUnitData(abilityData));
    }
    unitType.race = races[unitType.raceId];
  });
  return unitTypes;
}

Map loadImages(Map fileMap) {
  return fileMap["images"];
}