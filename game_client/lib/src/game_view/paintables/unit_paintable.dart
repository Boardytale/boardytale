part of world_view;

class UnitPaintable extends Paintable {
  ClientUnit unit;
  static Map<String, stage_lib.BitmapData> unitGlobalCache = {};
  static Map<String, stage_lib.BitmapData> teamGlobalCache = {};
  static Map<String, stage_lib.BitmapData> stepsGlobalCache = {};
  static Map<String, stage_lib.BitmapData> lifeGlobalCache = {};
  int _damageHeight = 14;
  int _armorHeight = 21;
  int _armorWidth = 15;
  static ImageElement _armorImage = ImageElement(
      src:
          "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAVCAYAAACZm7S3AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAYdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjEuNWRHWFIAAAKGSURBVDhPnZLdS9NhFMd/YhdFQhjlXHPLqZu692nq3hQq0E2F6Coi6EbowiiCsMALC8yguyCqKy8i6E1IerEoayhT0VaZrYv+hILITN3MTU/fc/abOlOQHvhyzrbz+Z7znD1K09FI4eEj8w5LzQBtJK2xYyNFS6w9GsXuGUpkChtal6m+JQmlRLsLQmS03CCz6x45fOPk9I2RrrSL9KYrYqI4A5MqsLQ57L5PtrpBctd/JJPzLlVUP/4/uNz9kAzmq1uDS2y3ATwimycM+JN01Zt7tgaX2XsB9JPdO0xVDTHZjd685s6BlkUVWFLzJGKSdMVnyOS4Q5UHnmJho+QKvCcrxs+6c6D5jxSzgeTNiyKGedOWmhey6crqJ4R/Jxv2hxIqlES+ILkfYpjva619TU7/BExeYoKxVRgLmfKH4quQ5AkRwxVV/Rj1LeAo4huJDEIpRW/q7vMF51VggSQPxhHjVFR2Cfd9hk0PiYHdE8nAKYELdMcv+4KzUuwPJhDnxIDFsKXmFTY9IjC/Mlf9FF5ZJxsMKHpzdwU6LXtVyNv0G3EWcVbgdMeRdNfABzHAdaYBmxQ+RWVdg1zsbZojb+OMGLAYttUNwyAMaAKPJEba4vPQuV7AOQoRKfuMF3aaXQ/GGfY0/oJmRNK5NoyxR9F1Uj7vLTp1HY8nhzmBWRrD6XwY/OAivhd34WIe2eGLpsct7fwC5WWYFZiFcYIwABzDU/wqsMP3TkDk3wAeXFufBbMA97EBi2Gj5SYZyq9NAzyxK18r42aUBbIOtX7O1Rjanxfub1fhWz8BtuVuy8sCWXLWf3ms7XvuHt3JCMMAOxRlxz8ga+Ws/8FgOrsd8MXNQUX5C6rsmLieQIf6AAAAAElFTkSuQmCC");

  UnitPaintable(this.unit, stage_lib.Stage stage, WorldViewService view, ClientField field)
      : super(view, field, stage) {
    // trigger preload
    UnitPaintable._armorImage;
    leftOffset = 0;
    topOffset = 0;
    width = settings.defaultFieldWidth;
    height = settings.defaultFieldHeight;
    createBitmap();
    view.gameService.worldParams.onResolutionLevelChanged.listen(createBitmap);
    unit.onFieldChanged.listen((_) {
      this.field = unit.field;
    });
    unit.onHealthChanged.listen(createBitmap);
    unit.onStepsChanged.listen(createBitmap);
  }

  Map<String, core.Image> get images => view.assets.images;

  int get resolutionLevel => gameService.worldParams.resolutionLevel;

  // TODO: explain
  double get pixelRatio => [0.5, 1.0, 2.0][resolutionLevel];

  double get lifeBarHeight => const [6.0, 5.0, 8.0][resolutionLevel];

  double get rectWidth => settings.defaultFieldWidth * pixelRatio;

  double get rectHeight => settings.defaultFieldHeight * pixelRatio;

  stage_lib.Rectangle get rectangle {
    return stage_lib.Rectangle(0, 0, rectWidth, rectHeight);
  }

  @override
  Future createBitmapInner() async {
    int resolutionLevel = gameService.worldParams.resolutionLevel;
//    String state = getUnitPaintedState(unit) + "_${resolutionLevel}";
    stage_lib.BitmapData data;
    //    if (!unitGlobalCache.containsKey(state)) {
    core.Image primaryImage = getPrimaryImage();
    data = stage_lib.BitmapData(rectWidth, rectHeight, stage_lib.Color.Transparent);
    ImageElement imageElement;
    if (primaryImage == images[unit.type.bigImageName]) {
      imageElement = await getBigImageData();
    } else {
      imageElement = ImageElement(src: primaryImage.data);
      await Future.delayed(Duration.zero);
    }
    data.drawPixels(
        stage_lib.BitmapData.fromImageElement(imageElement, 1 / pixelRatio * primaryImage.multiply),
        stage_lib.Rectangle(0, 0, primaryImage.width * pixelRatio / primaryImage.multiply,
            primaryImage.height * pixelRatio / primaryImage.multiply),
        stage_lib.Point(primaryImage.left * pixelRatio, primaryImage.top * pixelRatio));
    if (!unit.isAlive) {
      data.applyFilter(stage_lib.ColorMatrixFilter.grayscale());
      data.applyFilter(stage_lib.ColorMatrixFilter.adjust(brightness: 0.15));

      ImageElement deathImage = ImageElement(src: "img/death.png");
      await deathImage.onLoad.first;
//      data.drawPixels(stage_lib.BitmapData.fromImageElement(deathImage), getOverlayRect(), stage_lib.Point(0, 0));
      data.drawPixels(stage_lib.BitmapData.fromImageElement(deathImage),  stage_lib.Rectangle(0, 0, primaryImage.width * pixelRatio / primaryImage.multiply,
          primaryImage.height * pixelRatio / primaryImage.multiply),
          stage_lib.Point(primaryImage.left * pixelRatio, primaryImage.top * pixelRatio));
    }
//    unitGlobalCache[state] = data;
    if (unit.isAlive) {
      data.drawPixels(getLifeBar(), getLifeBarRect(), stage_lib.Point(rectWidth / 4, 0));
      data.drawPixels(getStepsBar(), getLifeBarRect(), stage_lib.Point(rectWidth / 4, rectHeight - lifeBarHeight));
    }
    if (resolutionLevel == 2 || unit.isAlive) {
      data.drawPixels(getPlayerColor(unit), getPlayerColorRect(), stage_lib.Point(rectWidth * 3 / 4 - 10, 7));
    }
    if (resolutionLevel == 2 && unit.isAlive) {
      data.drawPixels(
          getDamage(unit), getDamageCont(), stage_lib.Point(rectWidth / 4, rectHeight - lifeBarHeight - _damageHeight));
      if (unit.armor > 0) {
        data.drawPixels(getArmor(unit), getArmorCont(), stage_lib.Point(rectWidth / 4, lifeBarHeight));
      }
    }
    if (resolutionLevel == 2) {
      data.drawPixels(getUnitId(unit), getUnitIdCont(), stage_lib.Point(10, (rectHeight ~/ 2) - 8));
    }
    //    } else {
    //      data = unitGlobalCache[state];
    //    }
    bitmap = stage_lib.Bitmap(data);
    return;
  }

  stage_lib.Rectangle getOverlayRect() {
    return stage_lib.Rectangle(0, 0, width, height);
  }

  stage_lib.Rectangle getArmorCont() {
    return stage_lib.Rectangle(0, 0, rectWidth / 2, _armorHeight);
  }

  stage_lib.BitmapData getArmor(ClientUnit unit) {
    stage_lib.BitmapData armorItemData = stage_lib.BitmapData.fromImageElement(UnitPaintable._armorImage);
    stage_lib.BitmapData data = stage_lib.BitmapData(rectWidth / 2, _armorHeight, 0x00FFFFFF);
    var itemRect = stage_lib.Rectangle(0, 0, _armorWidth, _armorHeight);
    for (int i = 0; i < unit.armor; i++) {
      data.drawPixels(armorItemData, itemRect, stage_lib.Point(i * (_armorWidth + 10), 0));
    }
    return data;
  }

  stage_lib.Rectangle getDamageCont() {
    return stage_lib.Rectangle(0, 0, rectWidth / 2, _damageHeight);
  }

  stage_lib.BitmapData getDamage(ClientUnit unit) {
    // TODO: one bitmap data might be reduced
    stage_lib.BitmapData data = stage_lib.BitmapData(rectWidth / 2, _damageHeight, 0x55FFFFFF);
    var textField =
        stage_lib.TextField(unit.attack.join(" "), stage_lib.TextFormat('Spicy Rice', 12, stage_lib.Color.Black));
    stage_lib.BitmapData labelBitmap = stage_lib.BitmapData(rectWidth / 2, _damageHeight, stage_lib.Color.Transparent);
    labelBitmap.draw(textField);
    data.drawPixels(labelBitmap, stage_lib.Rectangle(0, 0, rectWidth / 2, _damageHeight), stage_lib.Point(10, 0));
    return data;
  }

  stage_lib.Rectangle getUnitIdCont() {
    return stage_lib.Rectangle(0, 0, 24, 16);
  }

  stage_lib.BitmapData getUnitId(ClientUnit unit) {
    // TODO: one bitmap data might be reduced
    stage_lib.BitmapData data = stage_lib.BitmapData(24, 16, 0x55FFFFFF);
    var textField = stage_lib.TextField(unit.id, stage_lib.TextFormat('Spicy Rice', 12, stage_lib.Color.Black));
    stage_lib.BitmapData labelBitmap = stage_lib.BitmapData(24, 16, stage_lib.Color.Transparent);
    labelBitmap.draw(textField);
    data.drawPixels(labelBitmap, stage_lib.Rectangle(0, 0, 24, 16), stage_lib.Point(0, 0));
    return data;
  }

  stage_lib.Rectangle getPlayerColorRect() {
    return stage_lib.Rectangle(0, 0, 10, 10);
  }

  stage_lib.BitmapData getPlayerColor(ClientUnit unit) {
    var shape = stage_lib.Shape();
    stage_lib.Graphics graphics = shape.graphics;

    stage_lib.BitmapData data = stage_lib.BitmapData(10, 10, stage_lib.Color.Transparent);
    if (unit.player.id == view.appService.currentPlayer.id) {
      data.fillRect(getPlayerColorRect(), stage_lib.Color.Black);
      data.fillRect(stage_lib.Rectangle(1, 1, 8, 8), unit.player.getStageColor());
    } else {
      graphics.beginPath();
      graphics.arc(5, 5, 3, 0, 2 * math.pi);
      graphics.closePath();
      graphics.fillColor(unit.player.getStageColor());
      graphics.beginPath();
      graphics.arc(5, 5, 4, 0, 2 * math.pi);
      graphics.closePath();
      graphics.strokeColor(stage_lib.Color.Black);
      data.draw(shape);
    }
    return data;
  }

  stage_lib.BitmapData getLifeBar() {
    int resolutionLevel = gameService.worldParams.resolutionLevel;
    String description = "${unit.type.health}_${unit.actualHealth}_$resolutionLevel";
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
      double bitWidth = (width - (unit.type.health + 1) * bitSpace) / unit.type.health;
      for (int i = 0; i < unit.type.health; i++) {
        stage_lib.Rectangle bitRectangle =
            stage_lib.Rectangle(i * bitWidth + (i + 1) * bitSpace, bitSpace, bitWidth, lifeBarHeight - 2 * bitSpace);
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

  Map<String, int> activeStepColors = {"me": 0xFF00D2FF, "team": 0xFFFFFF00, "enemy": 0xFFFF0000};
  Map<String, int> usedStepColors = {"me": 0xFF007088, "team": 0xFF787700, "enemy": 0xFF780000};

  stage_lib.BitmapData getStepsBar() {
    int resolutionLevel = gameService.worldParams.resolutionLevel;
    String description = "${unit.speed}_${unit.steps}_${resolutionLevel}";
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
        stage_lib.Rectangle bitRectangle =
            stage_lib.Rectangle(i * bitWidth + (i + 1) * bitSpace, bitSpace, bitWidth, lifeBarHeight - 2 * bitSpace);
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
    double width = gameService.worldParams.fieldWidth / 2;
    return stage_lib.Rectangle(0, 0, width, lifeBarHeight * pixelRatio);
  }

  String getUnitPaintedState(ClientUnit unit) {
    if (!unit.isAlive) {
      return "u${unit.type.name}h${unit.actualHealth}";
    }
    return "u${unit.type.name}h${unit.actualHealth}mh${unit.type.health}s${unit.steps}ms${unit.speed}a${unit.armor}r${unit.range}${unit.player.id}";
  }

  core.Image getPrimaryImage() {
    int resolutionLevel = gameService.worldParams.resolutionLevel;
    if (resolutionLevel == 0) {
      if (images.containsKey(unit.type.iconName)) {
        return images[unit.type.iconName];
      } else {
        return images[unit.type.imageName];
      }
    } else if (resolutionLevel == 1) {
      return images[unit.type.imageName];
    } else if (images.containsKey(unit.type.bigImageName)) {
      return images[unit.type.bigImageName];
    } else {
      return images[unit.type.imageName];
    }
  }

  Future<ImageElement> getBigImageData() {
    Completer<ImageElement> completer = Completer<ImageElement>();
    ImageElement imageElement;
    if (images.containsKey(unit.type.bigImageName)) {
      imageElement = ImageElement(src: "img/big_units/" + unit.type.bigImageName);
    } else {
      imageElement = ImageElement(src: images[unit.type.imageName].data);
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
