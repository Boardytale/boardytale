library world_model;

import 'dart:math';
import 'package:boardytale_commons/model/model.dart';
import 'package:stagexl/stagexl.dart' as stage_lib;
import 'package:utils/utils.dart';

part 'sized_field.dart';

class WorldModel {
  Notificator onDimensionsChanged = new Notificator();
  World get world => tale.map;
  Tale tale;
  Map<String, SizedField> fields = {};
  int userTopOffset = 0;
  int userLeftOffset = 0;
  double zoom = 1.0;
  static const double defaultFieldWidth = 100.0;
  double widthHeightRatio = sqrt(3) / 2;
  double fieldWidth;
  double fieldHeight;
  HexaBorders defaultHex;

  WorldModel(this.tale) {
    world.fields.forEach((k, v) {
      fields[k] = new SizedField(v, this);
    });
    defaultHex = new HexaBorders(this);
    recalculate();
  }

  void recalculate() {
    fieldWidth = zoom * defaultFieldWidth;
    fieldHeight = fieldWidth * widthHeightRatio;
    fields.forEach((k, v) => v.recalculate());
    defaultHex.recalculate();
    onDimensionsChanged.notify();
  }


  SizedField getFieldByMouseOffset(int x, int y) {
    // TODO: make segmentation over three axis ... Šmoďo, až se k tomu jednou dostaneš, předělej to
    double qWidth = fieldWidth / 4;
    int userTop = userTopOffset + y;
    int userLeft = userLeftOffset + x;
    int verticalSegment = userLeft ~/ qWidth;
    int horizontalSegment = userTop ~/ (fieldHeight / 2);
    if (verticalSegment % 3 == 0) {
      SizedField main = _getMainFieldBySegments(
          verticalSegment, horizontalSegment);
      if(main == null)return null;
      if (verticalSegment % 6 == 0) {
        double deltaTop = userTop - main.left.y;
        double deltaLeft = userLeft - main.left.x;
        if (horizontalSegment % 2 == 0) {
          // left upper
          if (deltaTop / deltaLeft < sqrt(3)) {
            return main;
          } else {
            return _getMainFieldBySegments(
                verticalSegment - 1, horizontalSegment);
          }
        } else {
          // left bottom
          if (deltaTop / deltaLeft < sqrt(3)) {
            return main;
          } else {
            return _getMainFieldBySegments(
                verticalSegment - 1, horizontalSegment);
          }
        }
      } else {
        double deltaTop = userTop - main.right.y;
        double deltaLeft = userLeft - main.right.x;
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
      return _getMainFieldBySegments(verticalSegment, horizontalSegment);
    }
  }

  SizedField _getMainFieldBySegments(int verticalSegment,
      int horizontalSegment) {
    int fx;
    int fy;
    fx = verticalSegment ~/ 3;
    if (fx % 2 == 1) {
      horizontalSegment--;
    }
    fy = horizontalSegment ~/ 2;
    return fields["${fx}_$fy"];
  }
}