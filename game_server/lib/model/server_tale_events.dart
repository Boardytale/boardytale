part of game_server;

class ServerTaleEvents {
  final ServerTale tale;
  Subject<ServerUnitUpdateReport> onUnitDies = PublishSubject();
  Map<String, core.ItemDrops> itemDropsByUnitId = {};

  ServerTaleEvents(this.tale);

  void setUnitReport(ServerUnitUpdateReport serverReport) {
    if (serverReport == null) {
      return;
    }
    core.UnitUpdateReport report = serverReport.coreReport;
    print("report unit:${report?.unit?.id} deltaHealth:${report?.deltaHealth} delta steps: ${report?.deltaSteps}");
    // if deltaH is -2 and unit now have -4, then just kicking to the corpse
    if (report.action.health != null && report.action.health <= 0 && report.deltaHealth < report.action.health) {
      onUnitDies.add(serverReport);
      manageDrops(serverReport, report);
    }
  }

  void registerItemDrop(core.ItemDrops itemDrops, core.Unit unit) {
    itemDropsByUnitId[unit.id] = itemDrops;
  }

  void manageDrops(ServerUnitUpdateReport serverReport, core.UnitUpdateReport report){
    List<core.UnitCreateOrUpdateAction> updates = serverReport.taleAction.unitUpdates;
    if (updates != null && updates.length > 1) {
      core.Unit attacker = tale.taleState.units[updates.first.unitId];
      ServerPlayer attackingPlayer = tale.taleState.humanPlayers[attacker.player.id];
      if(!itemDropsByUnitId.containsKey(report.unit.id)){
        return;
      }
      core.ItemDrops drops = itemDropsByUnitId[report.unit.id];
      int maxDrops = drops.maxItemDrops;
      drops.items.forEach((core.ItemDrop drop){
        if(maxDrops < 1){
          return;
        }
        double dice = math.Random.secure().nextDouble();
        if(drop.probability > dice){
          maxDrops--;
          if(drop.byName != null){
            attackingPlayer.currentGameGain.add(drop.byName);
          }else{
            // TODO: implement by price
            throw "by price is not implemented";
          }
        }
      });
    } else {
      print("unit probably dies on poison or by natural death");
    }
  }
}
