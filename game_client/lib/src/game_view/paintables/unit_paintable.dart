part of world_view;

class UnitPaintable extends Paintable {
  ClientUnit unit;
  SettingsService settings;
  static Map<String, stage_lib.BitmapData> unitGlobalCache = {};
  static Map<String, stage_lib.BitmapData> teamGlobalCache = {};
  static Map<String, stage_lib.BitmapData> stepsGlobalCache = {};
  static Map<String, stage_lib.BitmapData> lifeGlobalCache = {};

  UnitPaintable(
      this.unit,
      stage_lib.Stage stage,
      WorldViewService view,
      ClientField field,
      this.settings)
      : super(view, field, stage) {
    leftOffset = 0;
    topOffset = 0;
    height = world.fieldHeight.toInt();
    width = world.fieldWidth.toInt();
    createBitmap();
    view.clientWorldService.onResolutionLevelChanged.listen(createBitmap);
    unit.onFieldChanged.listen((_) {
      this.field = unit.field;
    });
    unit.onHealthChanged.listen(createBitmap);
    unit.onStepsChanged.listen(createBitmap);
  }

  ClientWorldService get world => view.clientWorldService;

  int get resolutionLevel => world.resolutionLevel;

  // TODO: explain
  double get pixelRatio => [0.5, 1.0, 2.0][resolutionLevel];

  double get lifeBarHeight => const [6.0, 5.0, 8.0][resolutionLevel];

  double get rectWidth => settings.defaultFieldWidth * pixelRatio;

  double get rectHeight => world.defaultFieldHeight * pixelRatio;

  stage_lib.Rectangle get rectangle {
    return stage_lib.Rectangle(0, 0, rectWidth, rectHeight);
  }

  @override
  Future createBitmapInner() async {
    int resolutionLevel = view.clientWorldService.resolutionLevel;
    String state = getUnitPaintedState(unit) + "_${resolutionLevel}";
    stage_lib.BitmapData data;
    if (!unitGlobalCache.containsKey(state)) {
      shared.Image primaryImage = getPrimaryImage();
      data = stage_lib.BitmapData(
          rectWidth, rectHeight, stage_lib.Color.Transparent);
      ImageElement imageElement;
      if (primaryImage == unit.type.bigImage) {
        imageElement = await getBigImageData();
      } else {
        imageElement = ImageElement(src: primaryImage.data);
        await Future.delayed(Duration.zero);
      }
      data.drawPixels(
          stage_lib.BitmapData.fromImageElement(
              imageElement, 1 / pixelRatio * primaryImage.multiply),
          stage_lib.Rectangle(
              0,
              0,
              primaryImage.width * pixelRatio / primaryImage.multiply,
              primaryImage.height * pixelRatio / primaryImage.multiply),
          stage_lib.Point(
              primaryImage.left * pixelRatio, primaryImage.top * pixelRatio));
      if (!unit.isAlive) {
        data.applyFilter(stage_lib.ColorMatrixFilter.grayscale());
      }
      unitGlobalCache[state] = data;
      if (unit.isAlive) {
        data.drawPixels(
            getLifeBar(), getLifeBarRect(), stage_lib.Point(rectWidth / 4, 0));
        data.drawPixels(getStepsBar(), getLifeBarRect(),
            stage_lib.Point(rectWidth / 4, rectHeight - lifeBarHeight));
      }
    } else {
      data = unitGlobalCache[state];
    }
    bitmap = stage_lib.Bitmap(data);
    return;
  }

  stage_lib.BitmapData getLifeBar() {
    int resolutionLevel = view.clientWorldService.resolutionLevel;
    String description =
        "${unit.type.health}_${unit.actualHealth}_$resolutionLevel";
    double bitSpace = [0.25, 0.5, 1.0][resolutionLevel];
    if (unit.type.health < 10) {
      bitSpace = 1.0;
    }
    if (lifeGlobalCache.containsKey(description)) {
      return lifeGlobalCache[description];
    } else {
      double width = rectWidth / 2;
      stage_lib.BitmapData data = stage_lib.BitmapData(width, lifeBarHeight);
      data.fillRect(getLifeBarRect(), stage_lib.Color.Black);
      double bitWidth =
          (width - (unit.type.health + 1) * bitSpace) / unit.type.health;
      for (int i = 0; i < unit.type.health; i++) {
        stage_lib.Rectangle bitRectangle = stage_lib.Rectangle(
            i * bitWidth + (i + 1) * bitSpace,
            bitSpace,
            bitWidth,
            lifeBarHeight - 2 * bitSpace);
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

  Map<String, int> activeStepColors = {
    "me": 0xFF00D2FF,
    "team": 0xFFFFFF00,
    "enemy": 0xFFFF0000
  };
  Map<String, int> usedStepColors = {
    "me": 0xFF007088,
    "team": 0xFF787700,
    "enemy": 0xFF780000
  };

  stage_lib.BitmapData getStepsBar() {
    int resolutionLevel = view.clientWorldService.resolutionLevel;
    String description =
        "${unit.speed}_${unit.steps}_${resolutionLevel}";
    double bitSpace = [0.25, 0.5, 1.0][resolutionLevel];
    if (unit.speed < 10) {
      bitSpace = 1.0;
    }
    if (stepsGlobalCache.containsKey(description)) {
      return stepsGlobalCache[description];
    } else {
      double width = rectWidth / 2;
      stage_lib.BitmapData data = stage_lib.BitmapData(width, lifeBarHeight);
      data.fillRect(getLifeBarRect(), stage_lib.Color.Black);
      double bitWidth = (width - (unit.speed + 1) * bitSpace) / unit.speed;
      for (int i = 0; i < unit.speed; i++) {
        stage_lib.Rectangle bitRectangle = stage_lib.Rectangle(
            i * bitWidth + (i + 1) * bitSpace,
            bitSpace,
            bitWidth,
            lifeBarHeight - 2 * bitSpace);
        if (i < unit.steps) {
          data.fillRect(bitRectangle, 0xFF00D2FF);
        } else {
          data.fillRect(bitRectangle, 0xFF007088);
        }
      }
      stepsGlobalCache[description] = data;
      return data;
    }
  }

  stage_lib.Rectangle getLifeBarRect() {
    double width = view.clientWorldService.fieldWidth / 2;
    return stage_lib.Rectangle(0, 0, width, lifeBarHeight * pixelRatio);
  }

  String getUnitPaintedState(ClientUnit unit) {
    if (!unit.isAlive) {
      return "u${unit.type.name}h${unit.actualHealth}";
    }
    return "u${unit.type.name}h${unit.actualHealth}mh${unit.type.health}s${unit.steps}ms${unit.speed}a${unit.armor}r${unit.range}${unit.handlerId}";
  }

  shared.Image getPrimaryImage() {
    int resolutionLevel = view.clientWorldService.resolutionLevel;
    if (resolutionLevel == 0) {
      if (unit.type.icon != null) {
        return unit.type.icon;
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
    Completer<ImageElement> completer = Completer<ImageElement>();
    ImageElement imageElement;
    if (unit.type.bigImage != null) {
      imageElement =
          ImageElement(src: "img/big_units/" + unit.type.bigImage.name);
    } else {
      imageElement = ImageElement(src: unit.type.image.data);
    }
    imageElement.onLoad.listen((_) {
      completer.complete(imageElement);
    });
    return completer.future;
  }

  void destroy() {
    super.destroy();
  }
}
