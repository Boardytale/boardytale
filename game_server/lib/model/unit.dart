part of game_server;

List<core.Ability> createServerAbilityList(core.AbilitiesEnvelope envelope) {
  List<core.Ability> out = [];
  if (envelope.move != null) {
    out.add(ServerMoveAbility()..fromEnvelope(envelope.move));
  }
  if (envelope.attack != null) {
    out.add(ServerAttackAbility()..fromEnvelope(envelope.attack));
  }
  if (envelope.shoot != null) {
    out.add(ServerShootAbility()..fromEnvelope(envelope.shoot));
  }
  if (envelope.heal != null) {
    out.add(ServerHealAbility()..fromEnvelope(envelope.heal));
  }
  return out;
}

class ServerUnit {

  static TaleAction perform(core.AbilityName name, core.Track track, core.UnitTrackAction action, ServerTale tale,
      core.Unit unit, ServerPlayer player, {io.WebSocket aiPlayerSocket}) {
    for (int i = 0; i < unit.abilities.length; i++) {
      ServerAbility ability = unit.abilities[i];
      if (ability.name == name) {
        return ability.perform(unit, track, action, tale, player.connection, aiPlayerSocket: aiPlayerSocket);
      }
    }
    return null;
  }

  static core.UnitCreateOrUpdateAction newTurn(core.Unit unit) {
    core.UnitCreateOrUpdateAction action = core.UnitCreateOrUpdateAction()
      ..unitId = unit.id
      ..steps = unit.type.speed
      ..actions = unit.type.actions
      ..stepsSpent = 0;
    return action;
  }
}

class ServerUnitUpdateReport {
  TaleAction taleAction;
  core.UnitUpdateReport coreReport;
}
