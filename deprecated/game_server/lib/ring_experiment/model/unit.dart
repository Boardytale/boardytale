part of boardytale.server.model;

class Unit extends commonLib.Unit{
  Unit(String id) : super(id);
  void newTurn() {
    super.newTurn();
    for (ServerAbility a in abilities) {
      if (a.trigger != null && a.trigger == commonLib.Ability.TRIGGER_MINE_TURN_START) {
        a.perform(this,null);
      }
    }
    field.refresh();
  }
}