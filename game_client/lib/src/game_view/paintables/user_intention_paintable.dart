part of world_view;

class UserIntentionPaintable extends Paintable {
  int color;

  UserIntentionPaintable(WorldViewService view, ClientField field,
      stage_lib.Stage stage, this.color)
      : super(view, field, stage) {
    if(field == null){
      throw "field cannot be null";
    }
    width = view.clientWorldService.defaultFieldWidth;
    height = view.clientWorldService.defaultFieldHeight;
    createBitmap();
//    view.clientWorldService.onResolutionLevelChanged.listen(createBitmap);
  }

  @override
  Future<Null> createBitmapInner() async {
    var shape = stage_lib.Shape();
    stage_lib.Graphics graphics = shape.graphics;
    graphics.beginPath();
    graphics.arc(width / 2, height / 2, width / 12, 0, 2 * math.pi);
    graphics.closePath();
    graphics.fillColor(color);
    stage_lib.BitmapData data =
        stage_lib.BitmapData(width, height, stage_lib.Color.Transparent);
    data.draw(shape);
    bitmap = stage_lib.Bitmap(data);
  }

  @override
  void destroy() {
    super.destroy();
  }
}

class UserIntentionConnectorPaintable extends UserIntentionPaintable {
  ClientField field2;

  UserIntentionConnectorPaintable(WorldViewService view, ClientField field,
      this.field2, stage_lib.Stage stage, int color)
      : super(view, field, stage, color) {
    width = view.clientWorldService.defaultFieldWidth * 2;
    height = view.clientWorldService.defaultFieldHeight * 2;
    leftOffset = - view.clientWorldService.defaultFieldWidth ~/ 2;
    topOffset = - view.clientWorldService.defaultFieldHeight ~/ 2;
  }

  @override
  Future<Null> createBitmapInner() async {
    var shape = stage_lib.Shape();
    stage_lib.Graphics graphics = shape.graphics;
    var deltaX = field.offset.x - field2.offset.x;
    var deltaY = field.offset.y - field2.offset.y;
    graphics.beginPath();
    graphics.moveTo(width, height);
    graphics.lineTo(width - deltaX * 2, height - deltaY * 2);
    graphics.closePath();
    graphics.strokeColor(color, 2);
    stage_lib.BitmapData data = stage_lib.BitmapData(
        width * 2, height * 2, stage_lib.Color.Transparent);
    data.draw(shape);
    bitmap = stage_lib.Bitmap(data);
  }

  @override
  void destroy() {
    super.destroy();
  }
}
