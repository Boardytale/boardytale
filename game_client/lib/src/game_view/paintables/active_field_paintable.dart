part of world_view;

class ActiveFieldPaintable extends Paintable {
  ImageElement highlightImage;

  ActiveFieldPaintable(WorldViewService view, ClientField field, stage_lib.Stage stage) : super(view, field, stage) {
    createBitmap();
  }

  @override
  Future createBitmapInner() async {
    highlightImage = ImageElement(src: "img/highlight.png");
    await highlightImage.onLoad.first;
    stage_lib.BitmapData data = stage_lib.BitmapData.fromImageElement(highlightImage);
    width = view.gameService.worldParams.fieldWidth.toInt();
    height = view.gameService.worldParams.fieldHeight.toInt();
    bitmap = stage_lib.Bitmap(data);
  }

  @override
  void destroy() {
    super.destroy();
  }
}
