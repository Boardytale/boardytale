part of deskovka_client;

class ClientWorld extends World {
  CanvasElement canvas;
  CanvasRenderingContext2D ctx;

  CanvasElement _trackCanvas;
  CanvasRenderingContext2D _trackCtx;

  DivElement container;
  DivElement overlay;

  Track _track;
  bool repaintRequested = true;
  static const int FIELD_WIDTH = 96;
  static const int FIELD_HEIGHT = 83;
  static const int CANVAS_BORDERS = 300;
  int diameter;
  List<WorldActionAdapter> adapters = [];
  WorldActionAdapter activeAdapter;
  var id;

  ClientWorld(int side) : super(side) {
    container = new DivElement();
    container.style
      ..position = "absolute"
      ..top = "-220px"
      ..left = "-150px";
    document.body.append(container);
    diameter = 2 * side + 1;
    canvas = new CanvasElement(width: 2000, height: 2000);
    canvas.style
      ..position = "absolute"
      ..top = "0px"
      ..left = "0px"
      ..zIndex = "1";
    container.append(canvas);

    overlay = new DivElement();
    overlay.style
      ..position = "absolute"
      ..top = "0px"
      ..left = "0px"
      ..width = "2000px"
      ..height = "2000px"
      ..zIndex = "1000";

    container.append(overlay);

    overlay.onMouseDown.listen(mousedown);
    overlay.onMouseMove.listen(mousemove);
    overlay.onMouseOut.listen(mouseout);
    overlay.onMouseUp.listen(mouseup);
    ctx = canvas.context2D;

    var x = 0;
    var y = 0;
    var strana = 7;
    for (var i = 0; i < 169; i++) {
      fields.add(
          new ClientField(this, i, x, y, getX(x, y), getY(x, y), this.ctx));
      if (x <= strana) {
        y++;
        if (y > strana + x) {
          x++;
          y = 0;
          if (x == strana + 1) y = 1;
        }
      } else {
        y++;
        if (y > strana * 2) {
          y = x - strana + 1;
          x++;
        }
      }
    }

    repaints.add(repaint);

    adapters.add(new MapMoveAdapter(container));
  }

  void repaint() {
    for (ClientField field in fields) {
      field.repaint();
    }
    repaintRequested = false;
  }

  int getX(int x, int y) {
    return ((FIELD_WIDTH * 3 / 4 + 1) * (diameter + y - x)).toInt() -
        583 +
        CANVAS_BORDERS;
  }

  int getY(int x, int y) {
    return (diameter - x - y - 4) * ((FIELD_HEIGHT ~/ 2) + 1) +
        ((FIELD_HEIGHT + 1) * (side + 1)).toInt() +
        CANVAS_BORDERS;
  }

  int _startPointX;
  int _startPointY;
  int _startPageX;
  int _startPageY;
  Field _lastField;

  void mousemove(MouseEvent e) {
    e.stopPropagation();
    e.preventDefault();
    if (activeAdapter == null) return;
    Point page = e.page;
    Rectangle offset = container.offset;

    int x = page.x.toInt() - offset.left - CANVAS_BORDERS;
    int y = page.y.toInt() - offset.top - CANVAS_BORDERS;

    Field field = getFieldByPixels(x, y);

    activeAdapter.onPixelMove(
        _startPointX, _startPointY, _startPageX, _startPageY, page.x, page.y);

    if (field != null) {
      if (_lastField != field) {
        _lastField = field;
        _track.fields.add(field);
        activeAdapter.onFieldChanged();
      }
    }
  }

  void mousedown(MouseEvent e) {
    e.stopPropagation();
    e.preventDefault();
    Point page = e.page;
    Rectangle offset = container.offset;

    _startPointX = offset.left;
    _startPointY = offset.top;

    _startPageX = page.x;
    _startPageY = page.y;

    // TODO: explain why 300
    int x = page.x.toInt() - offset.left - CANVAS_BORDERS;
    int y = page.y.toInt() - offset.top - CANVAS_BORDERS;
    Field field = getFieldByPixels(x, y);
    if (field == null) {
      return;
    }
    _lastField = field;
    _track = new Track([field]);

    adapters.sort((WorldActionAdapter a, WorldActionAdapter b) =>
        b.priority - a.priority);

    for (var adapter in adapters) {
      if (adapter.apply(field, e.button != 0)) {
        adapter.track = _track;
        adapter.onFieldDown(e.button != 0, e.shiftKey, e.altKey, e.ctrlKey);
        activeAdapter = adapter;
        break;
      }
    }
  }

  void mouseup(MouseEvent e) {
    e.stopPropagation();
    e.preventDefault();
    if (activeAdapter == null) {
      return;
    }
    activeAdapter.onFieldUp();
    activeAdapter = null;
  }

  void mouseout(MouseEvent e) {
    e.stopPropagation();
    e.preventDefault();
    if (activeAdapter == null) {
      return;
    }
    activeAdapter.onFieldUp();
    activeAdapter = null;
  }

  getFieldByPixels(int x, int y) {
    y += FIELD_HEIGHT ~/ 2 + 1;
    x--;
    x = (x - 45 * FIELD_WIDTH / 4 - diameter + FIELD_WIDTH / 2 + 1 + 512)
        .toInt();
    var b = (2 * y / (FIELD_HEIGHT + 1)).floor();
    var c = (2 * x / (FIELD_WIDTH + 1) - y / (FIELD_HEIGHT + 1)).floor();
    var d = (2 * x / (FIELD_WIDTH + 1) + y / (FIELD_HEIGHT + 1)).floor();
    var xx = diameter - 1 - ((b + d) / 3).floor();
    var yy = diameter - 1 + ((-b + c + 2) / 3).floor();
//    Field f = getField(xx, yy);
//    if(f!=null){
//      document.title = "${f.x}, ${f.y}";
//    }
    return getField(xx, yy);
  }

  Map toJson() {
    Map out = {};
    List unitCache = [];
    for (Unit u in gf.game.units) {
      unitCache.add(u.toSimpleJson());
    }
    out["units"] = unitCache;
    out["id"] = id;

    return out;
  }

  void moveTo(int top, int left) {
    container.style
      ..top = "${top}px"
      ..left = "${left}px";
  }

  void paintTrack(Track track, String color) {
    if (_trackCanvas == null) {
      _trackCanvas = new CanvasElement(width: 2000, height: 2000);
      _trackCanvas.style
        ..top = "0px"
        ..left = "0px"
        ..zIndex = "100"
        ..position = "absolute";
      container.append(_trackCanvas);
      _trackCtx = _trackCanvas.context2D;
    } else {
      if (_trackCtx == null) {
        _trackCtx = _trackCanvas.context2D;
      }
      _trackCtx.clearRect(0, 0, 2000, 2000);
    }
    _trackCtx.fillStyle = color;
    _trackCtx.strokeStyle = color;
    _trackCtx.lineWidth = 5;
    int dx = FIELD_WIDTH ~/ 2;
    int dy = FIELD_HEIGHT ~/ 2;
    int perimeter = 7;
    for (int i = 0; i < track.fields.length; i++) {
      ClientField field = track.fields[i];
      _trackCtx
        ..beginPath()
        ..arc(field.offsetX + dx, field.offsetY + dy, perimeter, 0, 2 * Math.PI)
        ..fill();
      if (i < track.fields.length - 1) {
        ClientField next = track.fields[i + 1];
        _trackCtx
          ..beginPath()
          ..moveTo(field.offsetX + dx, field.offsetY + dy)
          ..lineTo(next.offsetX + dx, next.offsetY + dy)
          ..stroke();
      }
    }
  }

  void clearTrack() {
    if (_trackCanvas != null) {
      _trackCanvas.remove();
    }
    _trackCanvas = null;
    _trackCtx = null;
  }
}

abstract class WorldActionAdapter {
  int priority = 0;
  Track track;
  bool apply(ClientField field, bool right);
  onFieldDown(bool right, bool shift, bool alt, bool ctrl);
  onPixelMove(int startPointX, int startPointY, int startPageX, int startPageY,
      int targetX, int targetY);
  onFieldChanged();
  onFieldUp();
}

class MapMoveAdapter extends WorldActionAdapter {
  Element container;
  MapMoveAdapter(this.container);
  @override
  bool apply(ClientField field, bool right) {
    return field.alivesOnField().isEmpty;
  }

  @override
  onFieldChanged() {
    // do nothing
  }

  @override
  onFieldUp() {
    // do nothing
  }

  @override
  onFieldDown(bool right, bool shift, bool alt, bool ctrl) {
    // do nothing
  }

  @override
  onPixelMove(int startPointX, int startPointY, int startPageX, int startPageY,
      int targetX, int targetY) {
    container.style
      ..top = "${startPointY - startPageY + targetY}px"
      ..left = "${startPointX - startPageX + targetX}px";
  }
}
