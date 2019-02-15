part of model;

abstract class InstanceGenerator {
  Unit unit(String id);
  Tale tale();
  Race race() => Race();
  Image image() => Image();
  UnitType unitType();
  Field field(String id, World world);
  LobbyPlayer player() => LobbyPlayer();
  Trigger trigger() => Trigger();
  Dialog dialog() => Dialog();
}

class CommonInstanceGenerator extends InstanceGenerator {
  @override
  Field field(String id, World world) => Field(id, world);
  @override
  Unit unit(String id) => Unit(id);
  @override
  UnitType unitType() => UnitType();
  @override
  Tale tale() => Tale();
}
