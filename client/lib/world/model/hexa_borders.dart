part of client_model;

class HexaBorders {
  FieldPoint topLeft;
  FieldPoint topRight;
  FieldPoint right;
  FieldPoint left;
  FieldPoint bottomLeft;
  FieldPoint bottomRight;
  ClientWorld world;

  HexaBorders(this.world);

  stageLib.Rectangle<num> get rectangle =>
      new stageLib.Rectangle<num>(
          0.0, 0.0, world.fieldWidth, world.fieldHeight);

  void recalculate() {
    double fieldWidth = world.fieldWidth;
    double fieldHeight = world.fieldHeight;
    double halfHeight = fieldHeight / 2;
    double quarterWidth = fieldWidth / 4;
    double left2 = quarterWidth * 3;
    topLeft = new FieldPoint(quarterWidth, 0.0);
    topRight = new FieldPoint(left2, 0.0);
    right = new FieldPoint(fieldWidth, halfHeight);
    left = new FieldPoint(0.0, halfHeight);
    bottomLeft = new FieldPoint(quarterWidth, fieldHeight);
    bottomRight = new FieldPoint(left2, fieldHeight);
  }
}

class FieldPoint {
  double x;
  double y;

  FieldPoint(this.x, this.y);
}