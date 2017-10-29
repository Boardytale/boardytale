import 'dart:math';
import 'package:angular/di.dart';
import 'package:boardytale_client/services/settings_service.dart';
import 'package:boardytale_client/services/tale_service.dart';
import 'package:boardytale_client/world/model/model.dart';
import 'package:boardytale_commons/model/model.dart' as commonModel;
import 'package:utils/utils.dart';

@Injectable()
class WorldService extends commonModel.World{
  SettingsService settings;
  @override
  TaleService tale;
  Map<String, Field> fields = {};
  List<Function> onModelLoaded = [];
  Notificator onDimensionsChanged = new Notificator();
  Notificator onResolutionLevelChanged = new Notificator();
  int userTopOffset = 0;
  int userLeftOffset = 0;
  double _zoom = 1.0;
  int _resolutionLevel = 1;
  double defaultFieldHeight;
  double widthHeightRatio = sqrt(3) / 2;
  double fieldWidth;
  double fieldHeight;
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
    onResolutionLevelChanged.notify();
  }

  WorldService(
      this.tale,
      this.settings
      ) {
    Map settingsData = {};
    settings.fromMap(settingsData);
    commonModel.setSettings(this.settings);
    tale.onTaleLoaded.add(taleLoaded);
  }

  void taleLoaded() {
    defaultFieldHeight = settings.defaultFieldWidth * widthHeightRatio;
    tale.map.fields.forEach((k, v) {
      fields[k] = new Field(v, this);
    });
    defaultHex = new HexaBorders(this);
    recalculate();
    onModelLoaded.forEach((f)=>f());
  }



  void recalculate() {
    fieldWidth = zoom * settings.defaultFieldWidth;
    fieldHeight = fieldWidth * widthHeightRatio;
    fields.forEach((k, v) => v.recalculate());
    defaultHex.recalculate();
    onDimensionsChanged.notify();
  }

  Field getFieldByMouseOffset(int x, int y) {
    // TODO: make segmentation over three axis ... Šmoďo, až se k tomu jednou dostaneš, předělej to
    double qWidth = fieldWidth / 4;
    int userTop = userTopOffset + y;
    int userLeft = userLeftOffset + x;
    if (userLeft < 0 || userTop < 0) return null;
    int verticalSegment = userLeft ~/ qWidth;
    int horizontalSegment = userTop ~/ (fieldHeight / 2);
    if (verticalSegment % 3 == 0) {
      // resolving field by corner
      Field main = _getMainFieldBySegments(
          verticalSegment, horizontalSegment);
      if (main == null) return null;
      if (verticalSegment % 6 == 0) {
        double deltaLeft = x - main.left.x;
        if (horizontalSegment % 2 == 0) {
          // left upper
          double deltaTop = main.left.y - y;
          if (deltaTop / deltaLeft < sqrt(3)) {
            return main;
          } else {
            return _getMainFieldBySegments(
                verticalSegment - 1, horizontalSegment);
          }
        } else {
          // left bottom
          double deltaTop = y - main.left.y;
          if (deltaTop / deltaLeft < sqrt(3)) {
            return main;
          } else {
            return _getMainFieldBySegments(
                verticalSegment - 1, horizontalSegment);
          }
        }
      } else {
        double deltaTop = y - main.right.y;
        double deltaLeft = x - main.right.x;
        if (horizontalSegment % 2 == 0) {
          // right upper
          if (deltaTop / deltaLeft < sqrt(3)) {
            return main;
          } else {
            return _getMainFieldBySegments(
                verticalSegment + 1, horizontalSegment);
          }
        } else {
          // right bottom
          if (deltaTop / deltaLeft > sqrt(3)) {
            return main;
          } else {
            return _getMainFieldBySegments(
                verticalSegment + 1, horizontalSegment);
          }
        }
      }
    } else {
      // resolving simple horizontal resolving
      return _getMainFieldBySegments(verticalSegment, horizontalSegment);
    }
  }

  Field _getMainFieldBySegments(int verticalSegment,
      int horizontalSegment) {
    int fx;
    int fy;
    if (verticalSegment < 0 || horizontalSegment < 0) return null;
    fx = verticalSegment ~/ 3;
    if (fx % 2 == 1) {
      if (horizontalSegment < 1) return null;
      horizontalSegment--;
    }
    fy = horizontalSegment ~/ 2;
    return fields["${fx}_$fy"];
  }
}