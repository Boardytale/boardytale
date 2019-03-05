part of world_view;

class MovePaintable extends Paintable {
  ImageElement image;

  MovePaintable(WorldViewService view, ClientField field, stage_lib.Stage stage)
      : super(view, field, stage) {
    createBitmap();
    _transformBitmap();
  }

  @override
  Future createBitmapInner() async {
    image = ImageElement(src: "img/track.png");
    await image.onLoad.first;
    stage_lib.BitmapData data =
    stage_lib.BitmapData.fromImageElement(image);
    bitmap = stage_lib.Bitmap(data);
  }

  @override
  void destroy() {
    super.destroy();
  }
}
