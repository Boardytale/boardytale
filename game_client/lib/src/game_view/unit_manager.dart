part of world_view;

class MapObjectsManager {
  stage_lib.Stage stage;
  WorldViewService worldViewService;
  SettingsService settings;
  List<Paintable> paintables = [];
  ActiveFieldPaintable activeField;
  List<UserIntentionPaintable> intentions = [];
  List<Paintable> abilityAssistance = [];

  ClientWorldService get clientWorldService => worldViewService.clientWorldService;

  MapObjectsManager(this.stage, this.worldViewService, this.settings) {
    activeField = ActiveFieldPaintable(worldViewService, null, stage);
//    clientWorldService.onUnitAdded.listen((unit) {
//      addUnit(unit);
//    });
    clientWorldService.onUnitAssistanceChanged.listen((ClientAbility ability) {
      abilityAssistance.forEach((p) => p.destroy());
      abilityAssistance.clear();
      if (ability == null) {
        return;
      }
      ability.highlights.forEach((highlight) {
        switch (highlight.highlightName) {
          case HighlightName.track:
            abilityAssistance.add(ImagePaintable(worldViewService, highlight.field, stage, "img/track.png"));
            break;
          case HighlightName.attack:
            abilityAssistance.add(ImagePaintable(worldViewService, highlight.field, stage, "img/attack.png"));
            break;
        }
      });
    });
  }

//  void addInitialUnits(){
//    clientWorldService.clientTaleService.units.values.forEach(addUnit);
//  }
//
//  void addUnit(shared.Unit unit) {
//    paintables.add(UnitPaintable(unit, stage, worldViewService, unit.field, settings));
//  }
//
//  void removeUnit(shared.Unit unit) {
//    paintables.removeWhere((paintable) {
//      if (paintable is UnitPaintable) {
//        return paintable.unit == unit;
//      }
//      return false;
//    });
//  }

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

  void addIntention(List<ClientField> fields, int color) {
    var test = (test) => test.color == color;
    intentions.where(test).forEach((paintable) {
      paintable.destroy();
    });
    intentions.removeWhere(test);
    if (fields != null) {
      var lastField = null;
      fields.forEach((field) {
        if (field == null) {
          return;
        }
        intentions.add(UserIntentionPaintable(worldViewService, field, stage, color));
        if (lastField != null) {
          intentions.add(UserIntentionConnectorPaintable(worldViewService, lastField, field, stage, color));
        }
        lastField = field;
      });
    }
  }

  void clear() {
    activeField = null;
    intentions.forEach((paintable)=>paintable.destroy());
    abilityAssistance.forEach((paintable)=>paintable.destroy());
    intentions.clear();
    abilityAssistance.clear();
  }
}
