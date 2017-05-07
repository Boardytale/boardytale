part of world_view;

/// lifecycle wrapper around stagexl bitmap fixed on map field
/// if active added to stage or waiting for image data
/// scaled according to map
///
///
///
abstract class Paintable {
  SizedField _field;
  bool _active = true;
  WorldView view;
  Stage stage;
  Bitmap _bitmap;

  Bitmap get bitmap => _bitmap;

  set bitmap(Bitmap value) {
    _bitmap = value;
    _resolveState();
  }

  int height;
  int width;
  int leftOffset;
  int topOffset;

  Paintable(this.view, this._field, this.stage) {
    view.model.onDimensionsChanged.add(_transformBitmap);
  }

  SizedField get field => _field;

  bool get active => _active;

  set active(bool value) {
    _active = value;
    _resolveState();
  }

  set field(SizedField value) {
    _field = value;
    _resolveState();
  }

  void _resolveState() {
    if (_active) {
      if (field != null && bitmap != null && !stage.contains(bitmap)) {
        stage.addChild(bitmap);
        _transformBitmap();
      }
    } else {
      stage.removeChild(bitmap);
    }
    _transformBitmap();
  }

  Future<Bitmap> createBitmap();

  // scale bitmap according to map
  void _transformBitmap() {
    bitmap.x = _field.offset.x + (leftOffset * view.model.zoom);
    bitmap.y = _field.offset.y + (topOffset * view.model.zoom);
    bitmap.width = width * view.model.zoom;
    bitmap.height = height * view.model.zoom;
  }

  void destroy();
}