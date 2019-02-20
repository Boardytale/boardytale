part of world_view;

class UnitManager {
  stage_lib.Stage stage;
  WorldViewService view;
  ClientTaleService tale;
  SettingsService settings;
  List<Paintable> paintables = [];
  ActiveFieldPaintable activeField;
  List<UserIntentionPaintable> intentions = [];

  UnitManager(this.stage, this.view, this.settings) {
    tale = view.model.clientTaleService;
    activeField = ActiveFieldPaintable(view, null, stage);
    tale.units.forEach((id, unit) {
      paintables.add(UnitPaintable(unit, stage, view, unit.field, settings));
    });
  }

  void setActiveField(ClientField field) {
    activeField.field = field;
  }

  void repaintActiveField() {}

  UnitPaintable getFirstUnitPaintableOnField(shared.Field field) {
    for (Paintable paintable in paintables) {
      if (paintable is! UnitPaintable) continue;
      if (paintable.field != field) continue;
      return (paintable as UnitPaintable);
    }
    return null;
  }

  void addIntention(ClientField field, int color) {
    var test = (test)=>test.color == color;
    intentions.where(test).forEach((paintable){
      paintable.destroy();
    });
    intentions.removeWhere(test);
    intentions.add(UserIntentionPaintable(view, field, stage, color));
  }
}
