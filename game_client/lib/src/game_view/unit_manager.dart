part of world_view;

class MapObjectsManager {
  stage_lib.Stage stage;
  WorldViewService worldViewService;
  List<Paintable> paintables = [];
  ActiveFieldPaintable activeField;
  List<UserIntentionPaintable> intentions = [];
  List<ImagePaintable> abilityAssistances = [];

  SettingsService get settings => worldViewService.settings;

  GameService get gameService => worldViewService.gameService;

  MapObjectsManager(this.stage, this.worldViewService) {
    activeField = ActiveFieldPaintable(worldViewService, null, stage);
    gameService.onUnitAssistanceChanged.listen((ClientAbility ability) {
      if (ability == null) {
        abilityAssistances.forEach((a) => a.destroy());
        abilityAssistances.clear();
        return;
      }
      List<ImagePaintable> removed = [];
      List<FieldHighlight> added = [];

      Map<HighlightName, String> paths = {
        HighlightName.track: "img/track.png",
        HighlightName.attack: "img/attack.png",
        HighlightName.shoot: "img/shoot.png",
        HighlightName.noGo: "img/nogo.png",
        HighlightName.heal: "img/heal.png",
      };

      abilityAssistances.forEach((ImagePaintable assistance) {
        if (!ability.highlights.any((highlight) {
          bool sameField = highlight.field == assistance.field;
          bool sameHighlight = highlight.highlightName == assistance.highlightName;
          return sameField && sameHighlight;
        })) {
          removed.add(assistance);
        }
      });

      ability.highlights.forEach((FieldHighlight highlight) {
        if (!abilityAssistances.any((assistance) {
          bool sameField = highlight.field == assistance.field;
          bool sameHighlight = highlight.highlightName == assistance.highlightName;
          return sameField && sameHighlight;
        })) {
          added.add(highlight);
        }
      });
      removed.forEach((assistance) {
        assistance.destroy();
        abilityAssistances.remove(assistance);
      });
      added.forEach((highlight) {
        abilityAssistances
            .add(ImagePaintable(worldViewService, highlight.field, stage, paths[highlight.highlightName], highlight.highlightName));
      });
    });

    gameService.currentBanter.listen((banter) async {
      if (banter == null || banter.unit == null) {
        return;
      }
      addBlinkingPaintable(banter.unit.field, "img/banter_higlight.png");
    });

    gameService.cancelOnField.listen((cancelOnFieldAction) {
      cancelOnFieldAction.actions.forEach((action) {
        addBlinkingPaintable(gameService.fields[action.fieldId], "img/cancel_on_field.png", 3);
      });
    });
  }

  void addBlinkingPaintable(ClientField field, String imagePath, [int blinks = 5]) async {
    ImagePaintable blinkingPaintable;
    for (var i = 0; i < blinks; i++) {
      blinkingPaintable = ImagePaintable(worldViewService, field, stage, imagePath, null);
      await Future.delayed(Duration(milliseconds: 300));
      if (blinkingPaintable != null) {
        blinkingPaintable.destroy();
      }
      await Future.delayed(Duration(milliseconds: 300));
    }
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
    abilityAssistances.forEach((paintable) => paintable.destroy());
    intentions.clear();
    abilityAssistances.clear();
  }
}
