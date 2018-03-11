part of model;

abstract class InstanceGenerator {
  Unit unit(int id, UnitType type);
  Tale tale() => new Tale();
  Race race() => new Race();
  Image image() => new Image();
  Ability ability(Map<String, dynamic> data) => Ability.createAbility(data);
  UnitType unitType();
  Field field(String id, World world);
  World world(Tale tale);
  Player player() => new Player();
  Trigger trigger() => new Trigger();
  Dialog dialog() => new Dialog();
}

class CommonInstanceGenerator extends InstanceGenerator {
  @override
  Field field(String id, World world) => new Field(id, world);

  @override
  Unit unit(int id, UnitType type) => new Unit(id, type);

  @override
  UnitType unitType() => new UnitType();

  @override
  World world(Tale tale) => new World(tale);
}
