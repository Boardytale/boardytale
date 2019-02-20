part of client_model;

@Injectable()
class ClientWorldService extends shared.World {
  SettingsService settings;
  covariant ClientTaleService tale;
  covariant Map<String, ClientField> fields = {};
  StreamController _onDimensionsChanged = StreamController.broadcast();
  Stream get onDimensionsChanged => _onDimensionsChanged.stream;
  StreamController _onResolutionLevelChanged = StreamController();
  Stream get onResolutionLevelChanged => _onResolutionLevelChanged.stream;
  int userTopOffset = 0;
  int userLeftOffset = 0;
  double _zoom = 1;
  int _resolutionLevel = 1;
  double defaultFieldHeight;
  double defaultFieldWidth;
  double widthHeightRatio = 1;
  double fieldWidth = 1;
  double fieldHeight = 1;
  HexaBorders defaultHex;
  double get zoom => _zoom;

  set zoom(double value) {
    _zoom = value;
    if (zoom < 0.6) {
      resolutionLevel = 0;
    } else if (zoom < 2) {
      resolutionLevel = 1;
    } else {
      resolutionLevel = 2;
    }
  }

  int get resolutionLevel => _resolutionLevel;

  set resolutionLevel(int value) {
    if (_resolutionLevel == value) return;
    _resolutionLevel = value;
    _onResolutionLevelChanged.add(null);
  }

  ClientWorldService(this.settings):super();

  void fromCreateEnvelope(shared.WorldCreateEnvelope envelope, ClientTaleService tale) {
    this.tale = tale;
    super.fromEnvelope(envelope);
    fields.clear();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        String key = "${x}_$y";
        ClientField field = ClientField(key, this);
        field.terrain = baseTerrain;
        fields[key] = field;
      }
    }
    defaultFieldWidth = settings.defaultFieldWidth;
    defaultFieldHeight = settings.defaultFieldWidth * widthHeightRatio;
    defaultHex = HexaBorders(this);
    recalculate();
  }

  void recalculate() {
    fieldWidth = zoom * settings.defaultFieldWidth;
    fieldHeight = fieldWidth * widthHeightRatio;
    fields.forEach((k, v) => v.recalculate());
    defaultHex.recalculate();
    _onDimensionsChanged.add(null);
  }

  ClientField getFieldByMouseOffset(num nx, num ny) {
    int x = nx.toInt();
    int y = ny.toInt();
    double qWidth = fieldWidth / 4;
    int userTop = userTopOffset + y;
    int userLeft = userLeftOffset + x;
    if (userLeft < 0 || userTop < 0) return null;
    int verticalSegment = userLeft ~/ qWidth;
    int horizontalSegment = userTop ~/ (fieldHeight / 2);
    if (verticalSegment % 3 == 0 || verticalSegment % 3 == 2) {   // vertical segments of sixtagram where left top/bottom == 0, middle top/bottom == 1 and right top/bottom == 2.
                                                                  // segments are rectangles where 0 & 2 are folded by two triangles from different fields, so we have to calculate which one is focused0
      // resolving field by corner
      ClientField main = _getMainFieldBySegments(verticalSegment, horizontalSegment);
      if (main == null) return null;
      double deltaLeft = x - main.left.x;

      // left upper
      double deltaTop = y - main.left.y;
      if (deltaTop < 0)
        deltaTop *= -1;

      if (deltaTop / deltaLeft < sqrt(3)) {
        return main;
      } else {
        return _getMainFieldBySegments(
            verticalSegment - 1, horizontalSegment);
      }
    } else {
      // resolving simple horizontal resolving
      return _getMainFieldBySegments(verticalSegment, horizontalSegment);
    }
  }

  ClientField _getMainFieldBySegments(int verticalSegment, int horizontalSegment) {
    int fx;
    int fy;
    if (verticalSegment < 0 || horizontalSegment < 0) return null;                    // if Segment doesn't exist
    fx = verticalSegment ~/ 3;
    if (fx % 2 == 1) {
      if (horizontalSegment < 1) return null;                                         // every second column is starting one segment later (because of
      horizontalSegment--;
    }
    fy = horizontalSegment ~/ 2;
    return fields["${fx}_$fy"];
  }
}
