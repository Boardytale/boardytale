part of world_view;

class ActiveFieldPaintable extends Paintable {
  ImageElement highlightImage;

  ActiveFieldPaintable(WorldViewService view, ClientField field, stage_lib.Stage stage)
      : super(view, field, stage) {
    createBitmap();
  }

  @override
  Future<stage_lib.Bitmap> createBitmapInner() async {
    highlightImage = ImageElement(src: "img/highlight.png");
    await highlightImage.onLoad.first;
    stage_lib.BitmapData data =
        stage_lib.BitmapData.fromImageElement(highlightImage);
    width = view.clientWorldService.fieldWidth.toInt();
    height = view.clientWorldService.fieldHeight.toInt();
    bitmap = stage_lib.Bitmap(data)
      ..x = 0
      ..y = 0
      ..width = width
      ..height = height;
    return bitmap;
  }

  @override
  void destroy() {
    super.destroy();
  }
}
