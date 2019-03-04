part of world_view;

class MovePaintable extends Paintable {
  ImageElement image;

  MovePaintable(WorldViewService view, ClientField field, stage_lib.Stage stage)
      : super(view, field, stage) {
    createBitmap();
  }

  @override
  Future<stage_lib.Bitmap> createBitmapInner() async {
    image = ImageElement(src: "img/track.png");
    await image.onLoad.first;
    stage_lib.BitmapData data =
    stage_lib.BitmapData.fromImageElement(image);
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
