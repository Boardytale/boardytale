part of game_server;

List<core.Ability> createServerAbilityList(core.AbilitiesEnvelope envelope) {
  List<core.Ability> out = [];
  if (envelope.move != null) {
    out.add(ServerMoveAbility()..fromEnvelope(envelope.move));
  }
  if (envelope.attack != null) {
    out.add(ServerAttackAbility()..fromEnvelope(envelope.attack));
  }
  return out;
}
//
class ServerUnit {
//  ServerPlayer player;
//  final ServerTale tale;
//
//  ServerUnit(this.tale, core.UnitCreateOrUpdateAction action, Map<String, core.Field> fields,
//      Map<String, core.Player> players, Map<String, core.UnitType> types)
//      : super(createServerAbilityList, action, fields, players, types);
//
  static TaleAction perform(core.AbilityName name, core.Track track, core.UnitTrackAction action, ServerTale tale, core.Unit unit, ServerPlayer player) {
    for (int i = 0; i < unit.abilities.length; i++) {
      ServerAbility ability = unit.abilities[i];
      if (ability.name == name) {
        return ability.perform(unit, track, action, tale, player.connection);
      }
    }
    return null;
  }
//
//  core.UnitUpdateReport addUnitUpdateAction(core.UnitCreateOrUpdateAction action, core.Field newField) {
//    core.UnitUpdateReport report = super.addUnitUpdateAction(action, newField);
//    if (report != null) {
//      tale.events.setUnitReport(report);
//    }
//    return report;
//  }
//
//  //
//  //  core.UnitUpdateReport move(core.Track track) {
//  //    core.UnitManipulateAction action = core.UnitManipulateAction();
//  //    core.LiveUnitState state = core.LiveUnitState();
//  //    state.steps = steps - track.fields.length + 1;
//  //    state.far = far + track.fields.length - 1;
//  //
//  //    if(steps == 0){
//  //      state.actions = 0;
//  //    }
//  //
//  //    action
//  //     ..isUpdate = true
//  //     ..unitId = id
//  //     ..fieldId = track.last.id
//  //     ..state = state;
//  //
//  //    return addUnitUpdateAction(action, track.last);
//  //  }
//
  static bool newTurn(core.Unit unit) {
    core.UnitCreateOrUpdateAction action = core.UnitCreateOrUpdateAction()
      ..unitId = unit.id
      ..steps = unit.type.speed
      ..actions = unit.type.actions
      ..far = 0;
    return unit.addUnitUpdateAction(action, null) != null;
  }
}
