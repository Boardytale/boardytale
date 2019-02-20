part of world_view;

class UserIntentionPaintable extends Paintable {
  ImageElement highlightImage;
  int color;

  UserIntentionPaintable(WorldViewService view, ClientField field, stage_lib.Stage stage, this.color)
      : super(view, field, stage) {
    width = view.clientWorldService.defaultFieldWidth.toInt();
    height = view.clientWorldService.defaultFieldHeight.toInt();
    print("construct $width $height");
    createBitmap();
  }

  @override
  Future<Null> createBitmapInner() async {
    print("create bitmap $width $height");
    var shape = stage_lib.Shape();
    stage_lib.Graphics graphics = shape.graphics;
    graphics.beginPath();
    graphics.arc(width/2, height/2, width/12, 0, 2 * math.pi);
    graphics.closePath();
    graphics.fillColor(color);
    stage_lib.BitmapData data = stage_lib.BitmapData(width, height, stage_lib.Color.Transparent);
    data.draw(shape);
    bitmap = stage_lib.Bitmap(data)
      ..x = 0
      ..y = 0
      ..width = width
      ..height = height;
  }

  @override
  void destroy() {
    super.destroy();
  }
}
