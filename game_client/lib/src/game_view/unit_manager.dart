part of world_view;

class MapObjectsManager {
  stage_lib.Stage stage;
  WorldViewService worldViewService;
  List<Paintable> paintables = [];
  ActiveFieldPaintable activeField;
  List<UserIntentionPaintable> intentions = [];
  List<Paintable> abilityAssistance = [];

  SettingsService get settings => worldViewService.settings;

  GameService get gameService => worldViewService.gameService;

  MapObjectsManager(this.stage, this.worldViewService) {
    activeField = ActiveFieldPaintable(worldViewService, null, stage);
//    clientWorldService.onUnitAdded.listen((unit) {
//      addUnit(unit);
//    });
    gameService.onUnitAssistanceChanged.listen((ClientAbility ability) {
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

  void setActiveField(ClientField field) {
    activeField.field = field;
  }

  void repaintActiveField() {}

  UnitPaintable getFirstUnitPaintableOnField(core.Field field) {
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
    intentions.forEach((paintable) => paintable.destroy());
    abilityAssistance.forEach((paintable) => paintable.destroy());
    intentions.clear();
    abilityAssistance.clear();
  }
}
