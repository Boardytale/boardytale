part of boardytale.server.model;

class ServerTale extends commonLib.Tale {
  ServerTale(commonLib.Resources resources) : super(resources);

  Unit nextPlayableUnit(Player player) {
    return units.values.firstWhere((commonLib.Unit unit) => unit.player == player && unit.isPlayable, orElse: returnNull);
  }
}
