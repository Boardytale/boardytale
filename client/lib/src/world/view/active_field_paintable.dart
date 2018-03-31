part of world_view;

class ActiveFieldPaintable extends Paintable {
  ImageElement highlightImage;

  ActiveFieldPaintable(WorldView view, Field field, stage_lib.Stage stage) : super(view, field, stage) {
    createBitmap();
  }

  @override
  Future<stage_lib.Bitmap> createBitmap() async {
    highlightImage = new ImageElement(src: "img/highlight.png");
    await highlightImage.onLoad.first;
    stage_lib.BitmapData data = new stage_lib.BitmapData.fromImageElement(highlightImage);
    width = view.model.fieldWidth.toInt();
    height = view.model.fieldHeight.toInt();
    bitmap = new stage_lib.Bitmap(data)
      ..x = 0
      ..y = 0
      ..width = width
      ..height = height;
    return bitmap;
  }

  @override
  void destroy() {
    // TODO: implement destroy
  }
}
