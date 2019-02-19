part of world_view;

class UserIntentionPaintable extends Paintable {
  ImageElement highlightImage;
  int color;

  UserIntentionPaintable(WorldViewService view, ClientField field, stage_lib.Stage stage, this.color)
      : super(view, field, stage) {
    createBitmap();
  }

  @override
  Future<stage_lib.Bitmap> createBitmapInner() async {
    var shape = stage_lib.Shape();
    stage_lib.Graphics graphics = shape.graphics;
    width = view.model.fieldWidth.toInt();
    height = view.model.fieldHeight.toInt();
    graphics.beginPath();
    graphics.arc(width/6, height/6, width/6, 0, 2 * math.pi);
    graphics.fillColor(color);
//    stage_lib.BitmapData bitmapData = stage_lib.BitmapData(width/3, height/3);
//    bitmapData.draw(shape);
//    stage_lib.Bitmap out = stage_lib.Bitmap(bitmapData);
//    out
//      ..x = width/3
//      ..y = width/3
//      ..width = width/3
//      ..height = height/3;
//    return out;
    highlightImage = ImageElement(src: "img/highlight.png");
    await highlightImage.onLoad.first;
    stage_lib.BitmapData data =
    stage_lib.BitmapData.fromImageElement(highlightImage);
    width = view.model.fieldWidth.toInt();
    height = view.model.fieldHeight.toInt();
    data.draw(shape);
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
