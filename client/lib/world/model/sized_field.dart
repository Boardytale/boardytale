part of world_model;

class SizedField extends HexaBorders {
  Field original;
  FieldPoint offset;

  SizedField(this.original, WorldModel world) :super(world);

  @override
  stage_lib.Rectangle<num> get rectangle =>
      new stage_lib.Rectangle<num>(
          offset.x, offset.y, world.fieldWidth, world.fieldHeight);

  void recalculate() {
    double fieldWidth = world.fieldWidth;
    double fieldHeight = world.fieldHeight;
    double halfHeight = fieldHeight / 2;
    double quarterWidth = fieldWidth / 4;
    offset = new FieldPoint(
        original.x * 3 / 4 * fieldWidth - world.userLeftOffset,
        original.y * fieldHeight + (original.x % 2) * fieldHeight / 2 -
            world.userTopOffset);
    double bottom = offset.y + fieldHeight;
    double left1 = offset.x + quarterWidth;
    double left2 = offset.x + quarterWidth * 3;
    topLeft = new FieldPoint(left1, offset.y);
    topRight = new FieldPoint(left2, offset.y);
    right = new FieldPoint(offset.x + fieldWidth, offset.y + halfHeight);
    left = new FieldPoint(offset.x, offset.y + halfHeight);
    bottomLeft = new FieldPoint(left1, bottom);
    bottomRight = new FieldPoint(left2, bottom);
  }
}

class FieldPoint {
  double x;
  double y;

  FieldPoint(this.x, this.y);
}

class HexaBorders {
  FieldPoint topLeft;
  FieldPoint topRight;
  FieldPoint right;
  FieldPoint left;
  FieldPoint bottomLeft;
  FieldPoint bottomRight;
  WorldModel world;

  HexaBorders(this.world);

  stage_lib.Rectangle<num> get rectangle =>
      new stage_lib.Rectangle<num>(
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