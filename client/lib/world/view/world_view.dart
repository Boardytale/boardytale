library world_view;

import 'dart:async';
import 'dart:html';
import 'package:boardytale_client/world/model/world_model.dart';
import 'package:boardytale_commons/model/model.dart';
import 'package:stagexl/stagexl.dart' as stage_lib;

part 'unit_manager.dart';

part 'paintable.dart';

part 'unit_paintable.dart';

part 'active_field_paintable.dart';

class WorldView {
  WorldModel model;
  stage_lib.Stage worldStage;
  ImageElement grassBackground;
  bool _imageLoaded = false;
  Map<int, stage_lib.Bitmap> fieldBitmaps = {};
  Map<String, ViewField> fields = {};
  UnitManager unitManager;

  WorldView(this.worldStage, this.model, stage_lib.Stage unitStage) {
    Map<int, ImageElement> resources = {};
    unitManager = new UnitManager(unitStage, this);
    ImageElement grassImage = new ImageElement(src: "img/8-trav.png");
    resources[0] = grassImage;
    ImageElement rockImage = new ImageElement(src: "img/rock.png");
    resources[1] = rockImage;
    Future.wait([grassImage.onLoad.first, rockImage.onLoad.first]).then((_) {
      _imageLoaded = true;
      createBitmapsByTerrain(resources);
      init();
    });
    model.fields.forEach((key, SizedField field) {
      fields[key] = new ViewField(field);
    });
  }

  void createBitmapsByTerrain(Map<int, ImageElement> resources) {
    HexaBorders defaultHex = model.defaultHex;
    var path = new stage_lib.Shape();
    stage_lib.Graphics graphics = path.graphics;
    graphics
      ..beginPath()
      ..moveTo(defaultHex.topLeft.x, defaultHex.topLeft.y)
      ..lineTo(defaultHex.topRight.x, defaultHex.topRight.y)..lineTo(
        defaultHex.right.x, defaultHex.right.y)..lineTo(
        defaultHex.bottomRight.x, defaultHex.bottomRight.y)..lineTo(
        defaultHex.bottomLeft.x, defaultHex.bottomLeft.y)..lineTo(
        defaultHex.left.x, defaultHex.left.y)
      ..closePath()
      ..strokeColor(0xff1E350D, 1.8);

    resources.forEach((int k, ImageElement v) {
      v.width = defaultHex.rectangle.width.toInt() + 1;
      v.height = defaultHex.rectangle.height.toInt() + 1;
      stage_lib.BitmapData data = new stage_lib.BitmapData.fromImageElement(v);
      data.draw(path);
      fieldBitmaps[k] = new stage_lib.Bitmap(data);
    });
  }

  void init() {
    Stopwatch stopwatch = new Stopwatch();
    stopwatch.start();
    fields.forEach((key, ViewField field) {
      if (field.terrain == null) {
        stage_lib.Bitmap terrain = new stage_lib.Bitmap(
            fieldBitmaps[field.original.terrainId].bitmapData.clone());
        if (field.label == null) {
          var textField = new stage_lib.TextField(field.original.id,
              new stage_lib.TextFormat(
                  'Spicy Rice', 24, stage_lib.Color.Black));
          stage_lib.BitmapData labelBitmap = new stage_lib.BitmapData(60, 30, stage_lib.Color.Transparent);
          labelBitmap.draw(textField);
          terrain.bitmapData.drawPixels(
              labelBitmap, new stage_lib.Rectangle(0, 0, 60, 30),
              new stage_lib.Point(20, 20));
        }
        worldStage.addChild(terrain);
        field.terrain = terrain;
      }
      field.terrain.x = field.offset.x;
      field.terrain.y = field.offset.y;
      field.terrain.width = model.fieldWidth;
      field.terrain.height = model.fieldHeight;
    });
    worldStage.materialize(0.0, 0.0);
    print(stopwatch.elapsedMilliseconds);
  }

  void repaint() {
    if (!_imageLoaded) {
      return;
    }
    init();
    worldStage.materialize(0.0, 16.6);
  }

  void setActiveField(SizedField field) {
    unitManager.setActiveField(field);
  }

}

class ViewField {
  SizedField sized;
  stage_lib.Bitmap terrain;
  stage_lib.TextField label;

  ViewField(this.sized) {
  }

  Field get original => sized.original;

  FieldPoint get offset => sized.offset;
}