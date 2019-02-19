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
      stageLib.Rectangle<num>(0.0, 0.0, world.fieldWidth, world.fieldHeight);

  void recalculate() {
    double fieldWidth = world.fieldWidth;
    double fieldHeight = world.fieldHeight;
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
