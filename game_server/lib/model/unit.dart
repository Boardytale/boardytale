part of game_server;

List<shared.Ability> createServerAbilityList(shared.AbilitiesEnvelope envelope) {
  List<shared.Ability> out = [];
  if (envelope.move != null) {
    out.add(ServerMoveAbility()..fromEnvelope(envelope.move));
  }
  if (envelope.attack != null) {
    out.add(ServerAttackAbility()..fromEnvelope(envelope.attack));
  }
  return out;
}

class ServerUnit extends shared.Unit {
  ServerPlayer player;
  final ServerTale tale;

  ServerUnit(this.tale, shared.UnitCreateOrUpdateAction action, Map<String, shared.Field> fields,
      Map<String, shared.Player> players, Map<String, shared.UnitType> types)
      : super(createServerAbilityList, action, fields, players, types);

  void perform(shared.AbilityName name, shared.Track track, shared.UnitTrackAction action, ServerTale tale) {
    for (int i = 0; i < abilities.length; i++) {
      ServerAbility ability = abilities[i];
      if (ability.name == name) {
        ability.perform(this, track, action, tale);
      }
    }
  }

  shared.UnitUpdateReport addUnitUpdateAction(shared.UnitCreateOrUpdateAction action, shared.Field newField) {
    shared.UnitUpdateReport report = super.addUnitUpdateAction(action, newField);
    if (report != null) {
      tale.events.setUnitReport(report);
    }
    return report;
  }

  //
  //  shared.UnitUpdateReport move(shared.Track track) {
  //    shared.UnitManipulateAction action = shared.UnitManipulateAction();
  //    shared.LiveUnitState state = shared.LiveUnitState();
  //    state.steps = steps - track.fields.length + 1;
  //    state.far = far + track.fields.length - 1;
  //
  //    if(steps == 0){
  //      state.actions = 0;
  //    }
  //
  //    action
  //     ..isUpdate = true
  //     ..unitId = id
  //     ..fieldId = track.last.id
  //     ..state = state;
  //
  //    return addUnitUpdateAction(action, track.last);
  //  }

  bool newTurn() {
    shared.UnitCreateOrUpdateAction action = shared.UnitCreateOrUpdateAction()
      ..unitId = id
      ..steps = type.speed
      ..actions = type.actions
      ..far = 0;
    return addUnitUpdateAction(action, null) != null;
  }
}
