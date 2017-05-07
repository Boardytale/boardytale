library world_view;

import 'dart:async';
import 'dart:html';
import 'package:boardytale_client/world/model/world_model.dart';
import 'package:boardytale_commons/model/model.dart';
import 'package:stagexl/stagexl.dart';

part 'unit_manager.dart';
part 'paintable.dart';
part 'unit_paintable.dart';

class WorldView {
  WorldModel model;
  Stage worldStage;
  ImageElement grassBackground;
  bool _imageLoaded = false;
  Map<int, ImageElement> resources = {};
  Map<String, ViewField> fields = {};
  UnitManager unitManager;

  WorldView(this.worldStage, this.model, Stage unitStage) {
    unitManager = new UnitManager(unitStage, this);
    ImageElement grassImage = new ImageElement(src: "img/8-trav.png");
    resources[0] = grassImage;
    ImageElement rockImage = new ImageElement(src: "img/rock.png");
    resources[1] = rockImage;
    Future.wait([grassImage.onLoad.first, rockImage.onLoad.first]).then((_) {
      _imageLoaded = true;
      init();
    });
    model.fields.forEach((key, SizedField field) {
      fields[key] = new ViewField(field);
    });
  }

  void init() {
    HexaBorders defaultHex = model.defaultHex;

    var path = new Shape();
    Graphics graphics = path.graphics;
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

    Map<int, BitmapData> resourcesData = {};
    resources.forEach((k, ImageElement v) {
      v.width = defaultHex.rectangle.width.toInt() + 1;
      v.height = defaultHex.rectangle.height.toInt() + 1;
      BitmapData data = new BitmapData.fromImageElement(v);
      data.draw(path);
      resourcesData[k] = data;
    });

//    BitmapData grassImageData = resources.getBitmapData("grass");
//    Bitmap transformedGrass = new Bitmap(grassImageData);
//    transformedGrass.width = defaultHex.rectangle.width;
//    transformedGrass.height = defaultHex.rectangle.height;
////    transformedGrass.scaleX = model.fieldWidth / grassImageData.width;
////    transformedGrass.scaleY = model.fieldHeight / grassImageData.height;
//
////    grassImageData.
//    BitmapData grassTerrainData = new BitmapData(
//        defaultHex.rectangle.width, defaultHex.rectangle.height);
//    grassTerrainData.draw(transformedGrass);
//    grassTerrainData.draw(path);
//    BitmapData rockTerrainData = new BitmapData.fromBitmapData(
//        resources.getBitmapData("rock"), defaultHex.rectangle);
//    rockTerrainData.draw(path);


    fields.forEach((key, ViewField field) {
      if (field.terrain == null) {
        Bitmap terrain = new Bitmap(new BitmapData.fromBitmapData(
            resourcesData[field.original.terrainId], defaultHex.rectangle));
        terrain.x = field.offset.x;
        terrain.y = field.offset.y;
        terrain.width = model.fieldWidth;
        terrain.height = model.fieldHeight;
        worldStage.addChild(terrain);
        field.terrain = terrain;
      } else {
        field.terrain.x = field.offset.x;
        field.terrain.y = field.offset.y;
        field.terrain.width = model.fieldWidth;
        field.terrain.height = model.fieldHeight;
      }
//      print("painted grass on ${field.offset.x} ${field.offset.y} ${model.fieldWidth}");

//      if (field.label == null) {
//        var textField = new TextField();
//        textField.defaultTextFormat =
//        new TextFormat('Spicy Rice', 30, Color.Black);
//        textField.text = field.original.id;
//        field.label = textField;
//        worldStage.addChild(textField);
//      }
//      field.label.x = field.offset.x + 20;
//      field.label.y = field.offset.y + 20;
//      field.label.width = 100;
//      field.label.height = 50;
//      field.label.wordWrap = true;
    });
    worldStage.materialize(0.0, 0.0);
  }

  void repaint() {
    if (!_imageLoaded) {
      return;
    }

//    stage.graphics.clear();
//    init();
//    stage.invalidate();
//    stage.juggler.advanceTime(16.6);
    // TODO: reuse children
//    stage.removeChildren();
    init();
    worldStage.materialize(0.0, 16.6);
//    _startTime+=16.6;
  }

  void setActiveField(SizedField field) {
    unitManager.setActiveField(field);
  }

}

class ViewField {
  SizedField sized;
  Bitmap terrain;
  TextField label;

  ViewField(this.sized) {
  }

  Field get original => sized.original;

  FieldPoint get offset => sized.offset;
}