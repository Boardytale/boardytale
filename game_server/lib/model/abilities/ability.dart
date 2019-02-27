part of game_server;

abstract class ServerAbility extends shared.Ability {
  void perform(ServerUnit unit, shared.Track track, shared.UnitTrackAction action, ServerTale tale);
}
