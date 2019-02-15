library world_view;

import 'dart:async';
import 'dart:html';
import 'package:game_client/src/services/settings_service.dart';
import 'package:game_client/src/game/model/model.dart';
import 'package:shared/model/model.dart' as shared;
import 'package:stagexl/stagexl.dart' as stage_lib;

part 'unit_manager.dart';

part 'paintable.dart';

part 'unit_paintable.dart';

part 'active_field_paintable.dart';

class WorldView {
  ClientWorld model;
  stage_lib.Stage worldStage;
  ImageElement grassBackground;
  bool _imageLoaded = false;
  Map<shared.Terrain, stage_lib.Bitmap> fieldBitmaps = {};
  Map<String, ViewField> fields = {};

  WorldView(this.worldStage, this.model) {
    Map<shared.Terrain, ImageElement> resources = {};
    ImageElement grassImage = ImageElement(src: "img/8-trav.png");
    resources[shared.Terrain.grass] = grassImage;
    ImageElement rockImage = ImageElement(src: "img/rock.png");
    resources[shared.Terrain.rock] = rockImage;
    Future.wait([grassImage.onLoad.first, rockImage.onLoad.first]).then((_) {
      _imageLoaded = true;
      createBitmapsByTerrain(resources);
      init();
    });
    model.fields.forEach((key, ClientField field) {
      fields[key] = ViewField(field);
    });
  }

  void createBitmapsByTerrain(Map<shared.Terrain, ImageElement> resources) {
    HexaBorders defaultHex = model.defaultHex;
    var path = stage_lib.Shape();
    stage_lib.Graphics graphics = path.graphics;
    graphics
      ..beginPath()
      ..moveTo(defaultHex.topLeft.x, defaultHex.topLeft.y)
      ..lineTo(defaultHex.topRight.x, defaultHex.topRight.y)
      ..lineTo(defaultHex.right.x, defaultHex.right.y)
      ..lineTo(defaultHex.bottomRight.x, defaultHex.bottomRight.y)
      ..lineTo(defaultHex.bottomLeft.x, defaultHex.bottomLeft.y)
      ..lineTo(defaultHex.left.x, defaultHex.left.y)
      ..closePath()
      ..strokeColor(0xff1E350D, 1.8);

    resources.forEach((shared.Terrain k, ImageElement v) {
      v.width = defaultHex.rectangle.width.toInt() + 1;
      v.height = defaultHex.rectangle.height.toInt() + 1;
      stage_lib.BitmapData data = stage_lib.BitmapData.fromImageElement(v);
      data.draw(path);
      fieldBitmaps[k] = stage_lib.Bitmap(data);
    });
  }

  void init() {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    fields.forEach((key, ViewField field) {
      if (field.terrain == null) {
        stage_lib.Bitmap terrain = stage_lib.Bitmap(
            fieldBitmaps[field.original.terrain].bitmapData.clone());
        if (field.label == null) {
          var textField = stage_lib.TextField(field.original.id,
              stage_lib.TextFormat('Spicy Rice', 24, stage_lib.Color.Black));
          stage_lib.BitmapData labelBitmap =
              stage_lib.BitmapData(60, 30, stage_lib.Color.Transparent);
          labelBitmap.draw(textField);
          terrain.bitmapData.drawPixels(labelBitmap,
              stage_lib.Rectangle(0, 0, 60, 30), stage_lib.Point(20, 20));
        }
        worldStage.addChild(terrain);
        field.terrain = terrain;
      }
      field.terrain.x = field.original.offset.x;
      field.terrain.y = field.original.offset.y;
      field.terrain.width = model.fieldWidth;
      field.terrain.height = model.fieldHeight;
    });
    worldStage.materialize(0.0, 0.0);
//    print(stopwatch.elapsedMilliseconds);
  }

  void repaint() {
    if (!_imageLoaded) {
      return;
    }
    init();
    worldStage.materialize(0.0, 16.6);
  }
}

class ViewField {
  ClientField original;
  stage_lib.Bitmap terrain;
  stage_lib.TextField label;

  ViewField(this.original) {}
}
