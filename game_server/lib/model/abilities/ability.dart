part of game_server;

abstract class ServerAbility extends core.Ability {
  TaleAction perform(core.Unit unit, core.Track track, core.UnitTrackAction action, ServerTale tale, Connection unitOnMoveConnection);
}
