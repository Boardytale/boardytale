part of boardytale.server.model;

class ServerTale extends model_lib.Tale{

  ServerTale(String stringData){
    Map data = parseJsonMap(stringData);
    TaleAssetsPack.unpack(data,this, new ServerClassGenerator());
  }
}