part of client_model;

class ClientField extends shared.Field {
  FieldPoint offset;
  FieldPoint topLeft;
  FieldPoint topRight;
  FieldPoint right;
  FieldPoint left;
  FieldPoint bottomLeft;
  FieldPoint bottomRight;

  ClientField(String id, ClientWorldService world) : super(id, world);

  ClientWorldService get clientWorld => world as ClientWorldService;

  stageLib.Rectangle<num> get rectangle => stageLib.Rectangle<num>(
      offset.x, offset.y, clientWorld.fieldWidth, clientWorld.fieldHeight);

  void recalculate() {
    double fieldWidth = clientWorld.fieldWidth;
    double fieldHeight = clientWorld.fieldHeight;
    double halfHeight = fieldHeight / 2;
    double quarterWidth = fieldWidth / 4;
    offset = FieldPoint(
        x * 3 / 4 * fieldWidth - clientWorld.userLeftOffset,
        y * fieldHeight +
            (x % 2) * fieldHeight / 2 -
            clientWorld.userTopOffset);
    double bottom = offset.y + fieldHeight;
    double left1 = offset.x + quarterWidth;
    double left2 = offset.x + quarterWidth * 3;
    topLeft = FieldPoint(left1, offset.y);
    topRight = FieldPoint(left2, offset.y);
    right = FieldPoint(offset.x + fieldWidth, offset.y + halfHeight);
    left = FieldPoint(offset.x, offset.y + halfHeight);
    bottomLeft = FieldPoint(left1, bottom);
    bottomRight = FieldPoint(left2, bottom);
  }

  Unit getFirstPlayableUnitOnField() {
    return units.firstWhere((shared.Unit unit) => unit.isPlayable,
        orElse: returnNull);
  }
}
