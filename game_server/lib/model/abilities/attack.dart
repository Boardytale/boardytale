part of game_server;

class ServerAttackAbility extends shared.AttackAbility implements ServerAbility {
  @override
  void perform(
      ServerUnit unit, shared.Track track, shared.UnitTrackAction action, ServerTale tale) {
    bool isValid = super.validate(invoker, track);

    shared.UnitManipulateAction action = shared.UnitManipulateAction();
    action
      ..unitId = unit.id
      ..actionId = action.actionId;

    if (!isValid) {
      action.isCancel = true;
      gateway.sendMessage(
          shared.ToClientMessage.fromTaleStateUpdate([action]), unit.player);
      return;
    }
//    unit.move(track);
//    action.isUpdate = true;
//    action.state = shared.LiveUnitState()
//      ..far = unit.far
//      ..newFieldId = unit.field.id;
//    unit.player.tale.sendNewState(action);
  }
}
