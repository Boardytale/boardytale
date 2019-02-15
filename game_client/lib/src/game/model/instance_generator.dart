import 'package:game_client/src/game/model/model.dart';
import 'package:shared/model/model.dart' as shared;

class ClientInstanceGenerator extends shared.InstanceGenerator {
  @override
  shared.Field field(String id, shared.World world) => ClientField(id, world);

  @override
  shared.Unit unit(String id) => Unit(id);

  @override
  shared.UnitType unitType() => shared.UnitType();

  @override
  shared.Tale tale() => ClientTale();

  @override
  shared.LobbyPlayer player() => shared.LobbyPlayer();
//  @override
//  model_lib.Ability ability(Map<String, dynamic> data) =>ClientAbility.createAbility(data);
}
