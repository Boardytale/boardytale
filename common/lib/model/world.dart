part of model;

class World {
  static World instance;
  int side;
  List<Field> fields = [];
  static const deltas = const[1,1,0,1,-1,0,-1,-1,0,-1,1,0];
  var id;

  World(this.side){
  }


  void createFields(){
    var x = 0;
    var y = 0;
    for (var i = 0; i < 169; i++) {
      fields.add(new Field(i, x, y));
      if (x <= side) {
        y++;
        if (y > side + x) {
          x++;
          y = 0;
          if (x == side + 1) y = 1;
        }
      } else {
        y++;
        if (y > side * 2) {
          y = x - side + 1;
          x++;
        }
      }
    }
  }

  List<Field> getFieldsRound(Field field) {
    List<Field> out = [];
    for(int i = 0;i<6;i=i+2){
      Field next = getField(field.x+deltas[i],field.y+deltas[i+1]);
      if(next!=null)out.add(next);
    }
    return out;
  }

  Field getField(int x, int y) {
    int a = 0;
    if (x >= 0 && x <= side && y >= 0 && y - x <= side) {
      a = ((x * x + x) / 2 + x * side + y).toInt(); 
      return fields[a];
    }
    if (x > side && x < 15 && y < 15 && x - y <= side) {
      a = (15 * (x - side - 1) - x / 2 * (x - 2 * side + 1) + side * (side + 3) + 1 + y).toInt();
      return fields[a];
    }
    return null;
  }

}
