part of client_model;

class HexaBorders {
  FieldPoint topLeft;
  FieldPoint topRight;
  FieldPoint right;
  FieldPoint left;
  FieldPoint bottomLeft;
  FieldPoint bottomRight;
  GameService gameService;

  HexaBorders(this.gameService);

  stageLib.Rectangle<num> get rectangle =>
      stageLib.Rectangle<num>(0.0, 0.0, gameService.worldParams.fieldWidth, gameService.worldParams.fieldHeight);

  void recalculate() {
    double fieldWidth = gameService.worldParams.fieldWidth;
    double fieldHeight = gameService.worldParams.fieldHeight;
    double halfHeight = fieldHeight / 2;
    double quarterWidth = fieldWidth / 4;
    double left2 = quarterWidth * 3;
    topLeft = FieldPoint(quarterWidth, 0.0);
    topRight = FieldPoint(left2, 0.0);
    right = FieldPoint(fieldWidth, halfHeight);
    left = FieldPoint(0.0, halfHeight);
    bottomLeft = FieldPoint(quarterWidth, fieldHeight);
    bottomRight = FieldPoint(left2, fieldHeight);
  }
}

class FieldPoint {
  double x;
  double y;

  FieldPoint(this.x, this.y);
}
