part of client_model;

class ClientField extends core.Field {
  FieldPoint offset;
  FieldPoint topLeft;
  FieldPoint topRight;
  FieldPoint right;
  FieldPoint left;
  FieldPoint bottomLeft;
  FieldPoint bottomRight;
  final GameService gameService;

  ClientWorldParams get params => gameService.worldParams;

  ClientField(String id, this.gameService) : super(id);

  stageLib.Rectangle<num> get rectangle =>
      stageLib.Rectangle<num>(offset.x, offset.y, params.fieldWidth, params.fieldHeight);

  void recalculate() {
    double fieldWidth = params.fieldWidth;
    double fieldHeight = params.fieldHeight;
    double halfHeight = fieldHeight / 2;
    double quarterWidth = fieldWidth / 4;
    offset = FieldPoint(x * 3 / 4 * fieldWidth - params.userLeftOffset,
        y * fieldHeight + (x % 2) * fieldHeight / 2 - params.userTopOffset);
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

  ClientUnit getFirstPlayableUnitOnField() {
    return units.firstWhere((core.Unit unit) => unit.isPlayable, orElse: returnNull);
  }
}
