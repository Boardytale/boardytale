part of boardytale.server.model;

class ServerClassGenerator extends model_lib.InstanceGenerator {
  @override
  model_lib.Field field(String id, model_lib.World world) => new model_lib.Field(id, world);

  @override
  model_lib.Unit unit(int id, model_lib.UnitType type) => new model_lib.Unit(id, type);

  @override
  model_lib.UnitType unitType() => new model_lib.UnitType();

  @override
  model_lib.World world(model_lib.Tale tale) => new model_lib.World(tale);

  @override
  model_lib.Player player() => new Player();

  @override
  model_lib.Tale tale() => new ServerTale();
}
