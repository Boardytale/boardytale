part of world_view;

class UnitPaintable extends Paintable {
  Unit unit;
//  List<Unit> units = [];
  SettingsService settings;
  static Map<String, stage_lib.BitmapData> unitGlobalCache = {};
  static Map<String, stage_lib.BitmapData> teamGlobalCache = {};
  static Map<String, stage_lib.BitmapData> stepsGlobalCache = {};
  static Map<String, stage_lib.BitmapData> lifeGlobalCache = {};

  UnitPaintable(
      this.unit,
      stage_lib.Stage stage,
      WorldView view,
      Field field,
      this.settings
      )
      : super(view, field, stage) {
    leftOffset = 0;
    topOffset = 0;
    height = world.fieldHeight.toInt();
    width = world.fieldWidth.toInt();
    createBitmap();
    view.model.onResolutionLevelChanged.add(createBitmap);
  }

  WorldService get world => view.model;

  int get resolutionLevel => world.resolutionLevel;

  double get pixelRatio => [0.5, 1.0, 2.0][resolutionLevel];

  double get lifeBarHeight => const[6.0, 5.0, 8.0][resolutionLevel];

  double get rectWidth => settings.defaultFieldWidth * pixelRatio;

  double get rectHeight => world.defaultFieldHeight * pixelRatio;

  stage_lib.Rectangle get rectangle {
    return new stage_lib.Rectangle(0, 0, rectWidth, rectHeight);
  }

  @override
  Future<stage_lib.Bitmap> createBitmap() async {
    int resolutionLevel = view.model.resolutionLevel;
    String state = getUnitPaintedState(unit) + "_${resolutionLevel}";
    commonModel.Image primaryImage = getPrimaryImage();
    stage_lib.BitmapData data;
    if (!unitGlobalCache.containsKey(state)) {
      data = new stage_lib.BitmapData(rectWidth, rectHeight, stage_lib.Color.Transparent);
      ImageElement imageElement;
      if (primaryImage == unit.type.bigImage) {
        imageElement = await
        getBigImageData();
      } else {
        imageElement = new ImageElement(src: primaryImage.data);
      }
      data.drawPixels(new stage_lib.BitmapData.fromImageElement(imageElement, 1 / pixelRatio * primaryImage.multiply),
          new stage_lib.Rectangle(0, 0, primaryImage.width * pixelRatio / primaryImage.multiply,
              primaryImage.height * pixelRatio / primaryImage.multiply),
          new stage_lib.Point(primaryImage.left * pixelRatio, primaryImage.top * pixelRatio)
      );
      unitGlobalCache[state] = data;
      data.drawPixels(getLifeBar(), getLifeBarRect(), new stage_lib.Point(rectWidth / 4, 0));
    } else {
      data = unitGlobalCache[state];
    }
    bitmap = new stage_lib.Bitmap(data);
    bitmap.width = world.fieldWidth;
    bitmap.height = world.fieldHeight;
    return bitmap;
  }

  stage_lib.BitmapData getLifeBar() {
    int resolutionLevel = view.model.resolutionLevel;
    String description = "${unit.type.health}_${unit.actualHealth}_$resolutionLevel";
    double bitSpace = [0.25, 0.5, 1.0][resolutionLevel];
    if (unit.type.health < 10) {
      bitSpace = 1.0;
    }
    if (lifeGlobalCache.containsKey(description)) {
      return lifeGlobalCache[description];
    } else {
      double width = rectWidth / 2;
      stage_lib.BitmapData data = new stage_lib.BitmapData(width, lifeBarHeight);
      data.fillRect(getLifeBarRect(), stage_lib.Color.Black);
      double bitWidth = (width - (unit.type.health + 1) * bitSpace) / unit.type.health;
      for (int i = 0; i < unit.type.health; i++) {
        stage_lib.Rectangle bitRectangle = new stage_lib.Rectangle(
            i * bitWidth + (i + 1) * bitSpace, bitSpace, bitWidth, lifeBarHeight - 2 * bitSpace);
        if (i < unit.actualHealth) {
          data.fillRect(bitRectangle, stage_lib.Color.Green);
        } else {
          data.fillRect(bitRectangle, stage_lib.Color.Red);
        }
      }
      lifeGlobalCache[description] = data;
      return data;
    }
  }

  stage_lib.Rectangle getLifeBarRect() {
    double width = view.model.fieldWidth / 2;
    return new stage_lib.Rectangle(0, 0, width, lifeBarHeight * pixelRatio);
  }

  String getUnitPaintedState(Unit unit) {
    return "u${unit.type.id}h${unit.actualHealth}mh${unit.type.health}s${unit
        .steps}ms${unit.type.speed}a${unit.armor}r${unit.range}";
  }

  commonModel.Image getPrimaryImage() {
    int resolutionLevel = view.model.resolutionLevel;
    if (resolutionLevel == 0) {
      if (unit.type.iconImage != null) {
        return unit.type.iconImage;
      } else {
        return unit.type.image;
      }
    } else if (resolutionLevel == 1) {
      return unit.type.image;
    } else if (unit.type.bigImage != null) {
      return unit.type.bigImage;
    } else {
      return unit.type.image;
    }
  }

  Future<ImageElement> getBigImageData() {
    Completer completer = new Completer();
    ImageElement imageElement;
    if (unit.type.bigImage != null) {
      imageElement =
      new ImageElement(src: "img/big_units/" + unit.type.bigImage.imageSrc);
    } else {
      imageElement = new ImageElement(src: unit.type.image.data);
    }
    imageElement.onLoad.listen((_) {
      completer.complete(imageElement);
    });
    return completer.future;
  }

  void destroy() {
    stage.removeChild(bitmap);
  }
}