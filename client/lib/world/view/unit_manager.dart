part of world_view;

class UnitManager {
  Stage stage;
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
    activeField._field = field;
    activeField._transformBitmap();
  }

  void repaintActiveField() {

  }
}

class ActiveFieldPaintable extends Paintable {
  Stage stage;
  ImageElement highlightImage;
  Bitmap highlightBitmap;

  ActiveFieldPaintable(WorldView view, SizedField field, Stage stage)
      : super(view, field, stage);

  @override
  Future<Bitmap> createBitmap() async {
    highlightImage = new ImageElement(src: "img/highlight.png");
    await highlightImage.onLoad.first;
    highlightBitmap =
    new Bitmap(new BitmapData.fromImageElement(highlightImage));
    highlightBitmap
      ..x = 100
      ..y = 100
      ..width = 100
      ..height = 100;
    return highlightBitmap;
  }

  @override
  void destroy() {
    // TODO: implement destroy
  }
}
