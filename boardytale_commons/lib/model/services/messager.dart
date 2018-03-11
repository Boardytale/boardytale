library model.messenger;
class Messenger{
  static Map<String,dynamic> message(String message){
    return {"type":"message","message":message};
  }
  static Map<String,dynamic> error(String message){
    return {"type":"error","message":message};
  }
}