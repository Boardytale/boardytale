part of model;

abstract class InstanceGenerator {
  Unit unit(String id);
  Tale tale(Resources resources);
  Race race() => Race();
  Image image() => Image();
//  Ability ability(Map<String, dynamic> data);
  UnitType unitType();
  Field field(String id, World world);
  World world(Tale tale);
  LobbyPlayer player() => LobbyPlayer();
  Trigger trigger() => Trigger();
  Dialog dialog() => Dialog();
  Resources resources() => Resources(this);
}

class CommonInstanceGenerator extends InstanceGenerator {
  @override
  Field field(String id, World world) => Field(id, world);
  @override
  Unit unit(String id) => Unit(id);
  @override
  UnitType unitType() => UnitType();
  @override
  World world(Tale tale) => World(tale);
  @override
  Tale tale(Resources resources) => Tale(resources);
//  @override
//  Ability ability(Map<String, dynamic> data) => Ability.createAbility(data);
}
