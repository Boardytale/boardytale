part of boardytale.server.model;

class ServerInstanceGenerator extends commonLib.InstanceGenerator {
  @override
  commonLib.Field field(String id, commonLib.World world) => new commonLib.Field(id, world);

  @override
  commonLib.Unit unit(int id) => new Unit(id);

  @override
  commonLib.UnitType unitType() => new commonLib.UnitType();

  @override
  commonLib.World world(commonLib.Tale tale) => new commonLib.World(tale);

  @override
  commonLib.Player player() => new Player();

  @override
  commonLib.Tale tale(commonLib.Resources resources) => new ServerTale(resources);

  @override
  ServerAbility ability(Map<String, dynamic> data) => ServerAbility.createAbility(data);
}
