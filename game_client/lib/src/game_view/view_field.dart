part of world_view;

class ViewField {
  final WorldViewService worldViewService;
  final ClientField original;
  Map<String, stage_lib.BitmapData> bitmapsByState = {};
  stage_lib.Bitmap terrain;
  stage_lib.TextField label;

  // there is a plan to have stackable units in the future
  List<UnitPaintable> unitPaintables = [];

  ViewField(this.original, this.worldViewService) {
    resolvePaintables();
    original.onUnitAdded.listen(resolvePaintables);
    original.onUnitRemoved.listen(resolvePaintables);
  }

  void resolvePaintables([_]) {
    if (original.units.isEmpty) {
      if (unitPaintables.isEmpty) {
        return;
      } else {
        _clearPaintables();
      }
    } else {
      shared.Unit painted = original.getFirstAliveOnField();
      if (painted == null) {
        painted = original.units.first;
      }
      if (unitPaintables.isNotEmpty && unitPaintables.first.unit == painted) {
        // unit is already painted
        return;
      } else {
        if (unitPaintables.isNotEmpty) {
          _clearPaintables();
        }
        addUnit(painted);
      }
    }
  }

  void _clearPaintables() {
    unitPaintables.forEach((p) {
      p.destroy();
    });
    unitPaintables.clear();
  }

  void addUnit(shared.Unit unit) {
    unitPaintables
        .add(UnitPaintable(unit, worldViewService.unitStage, worldViewService, unit.field, worldViewService.settings));
  }

  void setState(String state) {
    terrain.bitmapData = bitmapsByState[state];
  }

  String getStateLabel(bool showLabel) {
    return "${showLabel ? "s" : "n"}_${original.terrainStateShortcuts[original.terrain]}";
  }

  void refresh(bool showLabel) {
    String state = getStateLabel(showLabel);
    if (!bitmapsByState.containsKey(state)) {
      stage_lib.BitmapData terrainData = worldViewService.fieldBitmaps[original.terrain].bitmapData.clone();
      if (showLabel) {
        var textField = stage_lib.TextField(original.id, stage_lib.TextFormat('Spicy Rice', 18, stage_lib.Color.Black));
        stage_lib.BitmapData labelBitmap = stage_lib.BitmapData(60, 30, stage_lib.Color.Transparent);
        labelBitmap.draw(textField);
        terrainData.drawPixels(labelBitmap, stage_lib.Rectangle(0, 0, 60, 30), stage_lib.Point(20, 3));
      }
      bitmapsByState[state] = terrainData;
      if (terrain == null) {
        terrain = stage_lib.Bitmap(terrainData);
        worldViewService.worldStage.addChild(terrain);
      } else {
        setState(state);
      }
    } else {
      setState(state);
    }
    terrain.x = original.offset.x;
    terrain.y = original.offset.y;
    terrain.width = worldViewService.clientWorldService.fieldWidth;
    terrain.height = worldViewService.clientWorldService.fieldHeight;
  }
}
