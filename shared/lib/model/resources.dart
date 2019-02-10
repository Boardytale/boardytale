part of model;

@Typescript()
class Resources{
  Map<String,UnitType> unitTypes={};
  Map<String,Race> races={};
  Map<String, Image> images = new Map<String, Image>();
  Map<String, Map> abilities = new Map<String, Map>();
  final InstanceGenerator generator;

  Resources(this.generator);
}
