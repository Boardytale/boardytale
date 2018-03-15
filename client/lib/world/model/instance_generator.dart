import 'package:boardytale_client/world/model/model.dart';
import 'package:boardytale_commons/model/model.dart' as model_lib;

class ClientInstanceGenerator extends model_lib.InstanceGenerator {
  @override
  model_lib.Field field(String id, model_lib.World world) => new Field(id, world);

  @override
  model_lib.Unit unit(int id, model_lib.UnitType type) => new Unit(id, type);

  @override
  model_lib.UnitType unitType() => new model_lib.UnitType();

  @override
  model_lib.World world(model_lib.Tale tale) => new ClientWorld(tale);

  @override
  model_lib.Tale tale(model_lib.Resources resources) => new ClientTale(resources);
  @override
  model_lib.Player player() => new Player();
}
