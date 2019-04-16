part of world_view;

class ImagePaintable extends Paintable {
  ImageElement image;
  final String imagePath;

  ImagePaintable(WorldViewService view, ClientField field, stage_lib.Stage stage, this.imagePath)
      : super(view, field, stage) {
    createBitmap();
    _transformBitmap();
  }

  @override
  Future createBitmapInner() async {
    image = ImageElement(src: imagePath);
    await image.onLoad.first;
    stage_lib.BitmapData data = stage_lib.BitmapData.fromImageElement(image);
    bitmap = stage_lib.Bitmap(data);
  }

  @override
  void destroy() {
    super.destroy();
  }
}
