import 'dart:io';
import 'dart:convert';

const String LOWEST_ID = "lowestUnusedId";
const String PATH_HERE = "C:\\dart\\projects\\boardytale\\mock_storage\\";

void main(String method, String entityType, String entityName, String content){
  Directory oldCurrentDirectory = new Directory(Directory.current.path);
  Directory.current = new Directory(PATH_HERE);
  print('running gw');
  if(method == "save"){
    save(entityType, entityName, content);
  }
  Directory.current = oldCurrentDirectory;
}

List<String> getNames(String entityType){
  List<String> toReturn;
  Directory oldCurrentDirectory = new Directory(Directory.current.path);
  Directory.current = new Directory(PATH_HERE+"/storage");
  toReturn = _getNames(entityType);
  Directory.current = oldCurrentDirectory;
  return toReturn;
}

List<String> _getNames(String entityType){
  Directory dir = new Directory(entityType);
  File index = new File(entityType+".json");
  if(!(dir.existsSync()&&index.existsSync())){
    print("wrong entityType");
    return [];
  }
  Map<String, dynamic> json = JSON.decode(index.readAsStringSync());
  return json.keys.toList();
}

bool validate(String entityType, String content){
  Map<String, dynamic> json = JSON.decode(content);
}

String get(String entityType, String entityName){
  String toReturn;
  Directory oldCurrentDirectory = new Directory(Directory.current.path);
  Directory.current = new Directory(PATH_HERE+"/storage");
  toReturn = _get(entityType, entityName);
  Directory.current = oldCurrentDirectory;
  return toReturn;
}

String _get(String entityType, String entityName){
  Directory dir = new Directory(entityType);
  File index = new File(entityType+".json");
  if(!(dir.existsSync()&&index.existsSync())){
    print("wrong entityType");
    return null;
  }
  String entityId = JSON.decode(index.readAsStringSync())[entityName];
  if(entityId==null){
    print("entity with that name not found");
    return null;
  }
  return (new File(dir.path+"/"+entityId+".json")).readAsStringSync();
}

void save(String entityType, String entityName, String content){
  Directory oldCurrentDirectory = new Directory(Directory.current.path);
  Directory.current = new Directory(PATH_HERE+"/storage");
  _save(entityType, entityName, content);
  Directory.current = oldCurrentDirectory;
}

void _save(String entityType, String entityName, String content){
  Directory dir = new Directory(entityType);
  File index = new File(entityType+".json");

  if(!dir.existsSync()){
    dir.createSync();
    File lowestId = new File(entityType+"/"+LOWEST_ID);
    lowestId.createSync();
    lowestId.writeAsStringSync("0");
  }

  if(!index.existsSync()){
    index.createSync();
    index.writeAsStringSync("{}");
  }

  Map<String, String> json = JSON.decode(index.readAsStringSync());

  if(json.containsKey(entityName)){
    print("entity name already taken");
  }
  else{
    File idFile = new File(entityType+"/"+LOWEST_ID);
    int lowestUnusedId = int.parse(idFile.readAsStringSync());
    json[entityName] = lowestUnusedId.toString();
    File persist = new File(entityType+"/"+lowestUnusedId.toString()+".json");
    persist.writeAsStringSync(content);
    index.writeAsStringSync(JSON.encode(json));
    lowestUnusedId++;
    idFile.writeAsStringSync(lowestUnusedId.toString());
    print('saved!');
  }
}