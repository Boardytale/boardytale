part of world_view;

class ViewField {
  final WorldViewService worldViewService;
  final ClientField coreField;
  Map<String, stage_lib.BitmapData> bitmapsByState = {};
  stage_lib.Bitmap terrain;
  stage_lib.TextField label;

  // there is a plan to have stackable units in the future
  List<UnitPaintable> unitPaintables = [];

  ViewField(this.coreField, this.worldViewService) {
    resolvePaintables();
    coreField.onUnitAdded.listen(resolvePaintables);
    coreField.onUnitRemoved.listen(resolvePaintables);
  }

  void resolvePaintables([_]) {
    if (coreField.units.isEmpty) {
      if (unitPaintables.isEmpty) {
        return;
      } else {
        // no units on field, was some unit on field
        _clearPaintables();
      }
    } else {
      core.Unit painted = coreField.getFirstAliveOnField();
      if (painted == null) {
        painted = coreField.units.first;
      }
      if (unitPaintables.isNotEmpty && unitPaintables.first.unit == painted) {
        // unit is already painted
        if(unitPaintables.length > 1){
          print("clearing other units");
          _clearOthers(painted);
        }
        return;
      } else {
        if (unitPaintables.isNotEmpty) {
          _clearPaintables();
        }
        addUnit(painted);
      }
    }
  }

  void _clearOthers(ClientUnit unit){
    List<UnitPaintable> toRemove = [];
    unitPaintables.forEach((p) {
      if(p.unit != unit){
        p.destroy();
        toRemove.add(p);
      }
    });
    toRemove.forEach((p){
      unitPaintables.remove(p);
    });
  }

  void _clearPaintables() {
    unitPaintables.forEach((p) {
      p.destroy();
    });
    unitPaintables.clear();
  }

  void addUnit(core.Unit unit) {
    unitPaintables.add(UnitPaintable(unit, worldViewService.unitStage, worldViewService, unit.field));
  }

  void setState(String state) {
    terrain.bitmapData = bitmapsByState[state];
  }

  String getStateLabel(bool showLabel) {
    return "${showLabel ? "s" : "n"}_${coreField.terrainStateShortcuts[coreField.terrain]}";
  }

  void refresh(bool showLabel) {
    String state = getStateLabel(showLabel);
    if (!bitmapsByState.containsKey(state)) {
      stage_lib.BitmapData terrainData = worldViewService.fieldBitmaps[coreField.terrain].bitmapData.clone();
      if (showLabel) {
        var textField = stage_lib.TextField(coreField.id, stage_lib.TextFormat('Spicy Rice', 18, stage_lib.Color.Black));
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
    terrain.x = coreField.offset.x;
    terrain.y = coreField.offset.y;
    terrain.width = worldViewService.gameService.worldParams.fieldWidth;
    terrain.height = worldViewService.gameService.worldParams.fieldHeight;
  }
}
