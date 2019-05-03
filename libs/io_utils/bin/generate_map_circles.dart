import 'package:core/model/model.dart';

main() {
  String stringOfTargetTODO =
  """
  part of model;

class MapCircles{
  static List<String> getCircleAround(int radius, {int fieldX, int fieldY, String fieldId, Field field}) {
    int x = fieldX;
    int y = fieldY;
    if(field != null){
      x = field.x;
      y = field.y;
    }
    if(fieldId != null){
      var split = fieldId.split("_");
      x = int.parse(split.first);
      y = int.parse(split.last);
    }
    if(radius < 1){
      throw "Cannot get circle with radius \$radius";
    }
    if(radius > 15){
      throw "Cannot get circle with radius \$radius  .. too big";
    }
    if(x.isEven){
        switch(radius){
          case 1: return [..."];
          ...
      }
    List out = ["..."];
    if(radius == 5){
      return out;
    }
      if(radius >= 6){out.addAll(["..."]);}
      return out;
    }
    }else{
      switch(radius){
          case 1: return [..."];
          ...
      }
    List out = ["..."];
    if(radius == 5){
      return out;
    }
      if(radius >= 6){out.addAll(["..."]);}
      return out;
    }

    throw "Cannot get circle with radius \$radius";
  }
}

  """;

  int x = 16;
  int y = 16;
  Field center = Field("${x}_$y");
  List<Field> lastFields = [center];
  Set<String> allUsedFields = Set<String>();
  allUsedFields.add(center.id);
  Set<Field> out = Set<Field>();
  for (int i = 1; i < 5; i++) {
    List<Field> newLastFields = [];
    lastFields.forEach((field) {
      field.getCircle1Ids().map((id)=>Field(id)).forEach((field){
        if(!allUsedFields.contains(field.id)){
          allUsedFields.add(field.id);
          out.add(field);
          newLastFields.add(field);
        }
      });
    });
    print("case ${i}: return [${out.map((f){
      String xx = "x";
      if(f.x > x){
        xx = "x+${f.x-x}";
      }
      if(f.x < x){
        xx = "x${f.x-x}";
      }
      String yy = "y";
      if(f.y > y){
        yy = "y+${f.y-y}";
      }
      if(f.y < y){
        yy = "y${f.y-y}";
      }
      return "\"\${${xx}}_\${${yy}}\"";
    }).join(",")}];");
    lastFields = newLastFields;
  }
  // for 5
  List<Field> newLastFields = [];
  lastFields.forEach((field) {
    field.getCircle1Ids().map((id)=>Field(id)).forEach((field){
      if(!allUsedFields.contains(field.id)){
        allUsedFields.add(field.id);
        out.add(field);
        newLastFields.add(field);
      }
    });
  });
  print("List<String> out = [${out.map((f){
    String xx = "x";
    if(f.x > x){
      xx = "x+${f.x-x}";
    }
    if(f.x < x){
      xx = "x${f.x-x}";
    }
    String yy = "y";
    if(f.y > y){
      yy = "y+${f.y-y}";
    }
    if(f.y < y){
      yy = "y${f.y-y}";
    }
    return "\"\${${xx}}_\${${yy}}\"";
  }).join(",")}];");
  lastFields = newLastFields;


  for (int i = 6; i < 16; i++) {
    Set<Field> out = Set<Field>();
    List<Field> newLastFields = [];
    lastFields.forEach((field) {
      field.getCircle1Ids().map((id)=>Field(id)).forEach((field){
        if(!allUsedFields.contains(field.id)){
          allUsedFields.add(field.id);
          out.add(field);
          newLastFields.add(field);
        }
      });
    });
    print("if(radius >= ${i}){out.addAll([${out.map((f){
      String xx = "x";
      if(f.x > x){
        xx = "x+${f.x-x}";
      }
      if(f.x < x){
        xx = "x${f.x-x}";
      }
      String yy = "y";
      if(f.y > y){
        yy = "y+${f.y-y}";
      }
      if(f.y < y){
        yy = "y${f.y-y}";
      }
      return "\"\${${xx}}_\${${yy}}\"";
    }).join(",")}]);}");
    lastFields = newLastFields;
  }
}
