part of model;

class Resources{
  Map<String,UnitType> unitTypes={};
  Map<String,Race> races={};
  Map<String, Image> images = new Map<String, Image>();
  Map<String, Ability> abilities = new Map<String, Ability>();
  final InstanceGenerator generator;

  Resources(this.generator);
}