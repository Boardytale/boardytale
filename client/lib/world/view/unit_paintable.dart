part of world_view;


class UnitPaintable extends Paintable {
  Unit unit;

  UnitPaintable(this.unit, Stage stage, WorldView view, SizedField field)
      : super(view, field, stage) {
    leftOffset = unit.type.image.left;
    topOffset = unit.type.image.top;
    createBitmap().then((_) {
      _transformBitmap();
    });
  }

  void destroy() {
    stage.removeChild(bitmap);
  }

  @override
  Future<Bitmap> createBitmap() async {
    // TODO: cache image data across unit types
    ImageElement imageElement = new ImageElement(src: unit.type.image.data);
    height = unit.type.image.height;
    width = unit.type.image.width;
    bitmap = new Bitmap(new BitmapData.fromImageElement(imageElement));
    return bitmap;
  }
}