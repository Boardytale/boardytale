part of client_model;

class ClientWorldParams {
  int userTopOffset = 0;
  int userLeftOffset = 0;
  double _zoom = 1;
  int _resolutionLevel = 1;
  double fieldWidth = 1;
  double fieldHeight = 1;
  HexaBorders defaultHex;
  int width;
  int height;
  core.Terrain baseTerrain = core.Terrain.grass;
  BehaviorSubject<Null> onResolutionLevelChanged = BehaviorSubject();

  void recalculate(SettingsService settings) {
    fieldWidth = zoom * settings.defaultFieldWidth;
    fieldHeight = fieldWidth * settings.widthHeightRatio;
    defaultHex.recalculate();
  }

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
    onResolutionLevelChanged.add(null);
  }
}

class ClientWorldUtils {
  static ClientField getFieldByMouseOffset(num nx, num ny, GameService gameService) {
    int x = nx.toInt();
    int y = ny.toInt();
    double qWidth = gameService.worldParams.fieldWidth / 4;
    int userTop = gameService.worldParams.userTopOffset + y;
    int userLeft = gameService.worldParams.userLeftOffset + x;
    if (userLeft < 0 || userTop < 0) return null;
    int verticalSegment = userLeft ~/ qWidth;
    int horizontalSegment = userTop ~/ (gameService.worldParams.fieldHeight / 2);
    if (verticalSegment % 3 == 0 || verticalSegment % 3 == 2) {
      // vertical segments of sixtagram where left top/bottom == 0, middle top/bottom == 1 and right top/bottom == 2.
      // segments are rectangles where 0 & 2 are folded by two triangles from different fields, so we have to calculate which one is focused0
      // resolving field by corner
      ClientField main = _getMainFieldBySegments(verticalSegment, horizontalSegment, gameService);
      if (main == null) return null;
      double deltaLeft = x - main.left.x;

      // left upper
      double deltaTop = y - main.left.y;
      if (deltaTop < 0) deltaTop *= -1;

      if (deltaTop / deltaLeft < sqrt(3)) {
        return main;
      } else {
        return _getMainFieldBySegments(verticalSegment - 1, horizontalSegment, gameService);
      }
    } else {
      // resolving simple horizontal resolving
      return _getMainFieldBySegments(verticalSegment, horizontalSegment, gameService);
    }
  }

  static ClientField _getMainFieldBySegments(int verticalSegment, int horizontalSegment, GameService gameService) {
    int fx;
    int fy;
    if (verticalSegment < 0 || horizontalSegment < 0) return null; // if Segment doesn't exist
    fx = verticalSegment ~/ 3;
    if (fx % 2 == 1) {
      if (horizontalSegment < 1) return null; // every second column is starting one segment later (because of
      horizontalSegment--;
    }
    fy = horizontalSegment ~/ 2;
    return gameService.fields["${fx}_$fy"];
  }

  static void fromEnvelope(core.World envelope, GameService gameService) {
    gameService.worldParams.width = envelope.width;
    gameService.worldParams.height = envelope.height;
    gameService.fields.clear();
    for (int x = 0; x < gameService.worldParams.width; x++) {
      for (int y = 0; y < gameService.worldParams.height; y++) {
        String key = "${x}_$y";
        ClientField field = ClientField(key, gameService);
        if (envelope.fields.containsKey(key)) {
          field.terrain = envelope.fields[key].terrain;
        } else {
          field.terrain = gameService.worldParams.baseTerrain;
        }
        gameService.fields[key] = field;
      }
    }
  }

  static Map<String, core.FieldCreateEnvelope> createFieldsData(core.World envelope) {
    Map<String, core.FieldCreateEnvelope> fieldsData = envelope.fields;
    Map<String, core.FieldCreateEnvelope> indexedFieldsData = {};
    if (fieldsData != null) {
      fieldsData.forEach((String k, core.FieldCreateEnvelope v) {
        if (v is int) {
          indexedFieldsData[k] = v;
        }
        if (v is Map<String, dynamic>) {
          indexedFieldsData[k] = core.FieldCreateEnvelope()..terrain = envelope.baseTerrain;
        }
      });
    }
    return fieldsData;
  }
}
