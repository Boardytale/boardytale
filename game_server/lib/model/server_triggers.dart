part of game_server;

class ServerTriggers {
  final shared.Triggers triggers;
  final ServerTale tale;

  ServerTriggers(this.tale, this.triggers) {
    tale.events.onUnitDies.listen((report) {
      triggers.onUnitDies.forEach((trigger) {
        if (trigger.action.victoryCheckAction != null) {
          print("check victory action");
        }
      });
    });
  }
}
