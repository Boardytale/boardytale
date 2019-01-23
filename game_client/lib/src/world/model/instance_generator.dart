import 'package:game_client/src/world/model/model.dart';
import 'package:shared/model/model.dart' as model_lib;

class ClientInstanceGenerator extends model_lib.InstanceGenerator {
  @override
  model_lib.Field field(String id, model_lib.World world) => new Field(id, world);

  @override
  model_lib.Unit unit(String id) => new Unit(id);

  @override
  model_lib.UnitType unitType() => new model_lib.UnitType();

  @override
  model_lib.World world(model_lib.Tale tale) => new ClientWorld(tale);

  @override
  model_lib.Tale tale(model_lib.Resources resources) => new ClientTale(resources);
  @override
  model_lib.Player player() => new Player();
//  @override
//  model_lib.Ability ability(Map<String, dynamic> data) =>ClientAbility.createAbility(data);
}
