part of client_model;

class Field extends commonModel.Field {
  FieldPoint offset;
  FieldPoint topLeft;
  FieldPoint topRight;
  FieldPoint right;
  FieldPoint left;
  FieldPoint bottomLeft;
  FieldPoint bottomRight;

  Field(String id, ClientWorld world) : super(id, world);

  ClientWorld get clientWorld => world as ClientWorld;

  stageLib.Rectangle<num> get rectangle =>
      new stageLib.Rectangle<num>(offset.x, offset.y, clientWorld.fieldWidth, clientWorld.fieldHeight);

  void recalculate() {
    double fieldWidth = clientWorld.fieldWidth;
    double fieldHeight = clientWorld.fieldHeight;
    double halfHeight = fieldHeight / 2;
    double quarterWidth = fieldWidth / 4;
    offset = new FieldPoint(x * 3 / 4 * fieldWidth - clientWorld.userLeftOffset,
        y * fieldHeight + (x % 2) * fieldHeight / 2 - clientWorld.userTopOffset);
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

  Unit getFirstPlayableUnitOnField() {
    return units.firstWhere((commonModel.Unit unit) => unit.isPlayable, orElse: returnNull);
  }
}
