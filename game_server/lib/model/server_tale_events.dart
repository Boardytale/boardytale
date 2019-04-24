part of game_server;

class ServerTaleEvents {
  final ServerTale tale;
  Subject<core.UnitUpdateReport> onUnitDies = PublishSubject();

  ServerTaleEvents(this.tale);

  void setUnitReport(core.UnitUpdateReport report) {
    if (report == null) {
      return;
    }
    print("report unit:${report?.unit?.id} deltaHealth:${report?.deltaHealth} delta steps: ${report?.deltaSteps}");
    // if deltaH is -2 and unit now have -4, then just kicking to the corpse
    if (report.action.health != null && report.action.health <= 0 && report.deltaHealth < report.action.health) {
      onUnitDies.add(report);
    }
  }
}
