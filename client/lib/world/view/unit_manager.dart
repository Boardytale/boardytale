part of world_view;

class UnitManager {
  stage_lib.Stage stage;
  WorldView view;
  Tale tale;
  List<Paintable> paintables = [];
  ActiveFieldPaintable activeField;

  UnitManager(this.stage, this.view) {
    tale = view.model.tale;
    activeField = new ActiveFieldPaintable(view, null, stage);
    tale.units.forEach((id, unit) {
      SizedField field = view.model.fields[unit.fieldId];
      paintables.add(new UnitPaintable(unit, stage, view, field));
    });
  }

  void setActiveField(SizedField field) {
    activeField.field = field;
  }

  void repaintActiveField() {

  }
}
