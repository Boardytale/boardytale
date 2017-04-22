part of model;

class World {
  int width;
  int height;
  int baseTerrainId = 0;
  Map<String, Field> fields = {};
  Field startField;


  World(){

  }

  void fromMap(Map data){
    width = data["width"];
    height = data["height"];
    baseTerrainId = data["baseTerrain"];
    Map<String, dynamic> fieldsData = data["fields"];
    Map<String, Map> indexedFieldsData = {};
    if(fieldsData != null){
     fieldsData.forEach((k,v){
       if(v is int){
         indexedFieldsData[k] = {"terrain": v};
       }
       if(v is Map){
         indexedFieldsData[k] = v;
       }
     });
    }
    fields.clear();
    for(int x = 0;x<width;x++){
      for(int y = 0;y<height;y++){
        String key = "${x}_$y";
        Field field = new Field(key, this);
        if(indexedFieldsData.containsKey(key)){
          field.fromMap(indexedFieldsData[key]);
        }
      }
    }

    dynamic __startField = data["startField"];
    if(__startField is String){
      startField = fields[__startField];
    }else{
      throw "Start field must be set";
    }

  }
}
