part of world_view;

class UnitManager {
  stage_lib.Stage stage;
  WorldView view;
  TaleService tale;
  SettingsService settings;
  List<Paintable> paintables = [];
  ActiveFieldPaintable activeField;

  UnitManager(
      this.stage,
      this.view,
      this.settings
      ) {
    tale = view.model.tale;
    activeField = new ActiveFieldPaintable(view, null, stage);
    tale.units.forEach((id, unit) {
      Field field = view.model.fields[unit.fieldId];
      unit.field = field;
      paintables.add(new UnitPaintable(new Unit.fromUnit(unit), stage, view, field, settings));
    });
  }

  void setActiveField(Field field) {
    activeField.field = field;
  }

  void repaintActiveField() {

  }

  UnitPaintable getFirstUnitPaintableOnField(commonModel.Field field) {
    for(Paintable paintable in paintables){
      if(paintable is! UnitPaintable) continue;
      if(paintable.field!=field) continue;
      return (paintable as UnitPaintable);
    }
    return null;
  }
}
