import 'package:game_client/src/world/model/model.dart';
import 'package:shared/model/model.dart' as shared;

class ClientInstanceGenerator extends shared.InstanceGenerator {
  @override
  shared.Field field(String id, shared.World world) => Field(id, world);

  @override
  shared.Unit unit(String id) => Unit(id);

  @override
  shared.UnitType unitType() => shared.UnitType();

  @override
  shared.World world(shared.Tale tale) => ClientWorld(tale);

  @override
  shared.Tale tale(shared.Resources resources) => ClientTale(resources);

  @override
  shared.LobbyPlayer player() => shared.LobbyPlayer();
//  @override
//  model_lib.Ability ability(Map<String, dynamic> data) =>ClientAbility.createAbility(data);
}
