part of model;

@JsonSerializable(nullable: false)
@Typescript()
class User {
  String id;
  String name;

  static User fromJson(Map data){
    return _$UserFromJson(data);
  }

  Map toJson(){
    return _$UserToJson(this);
  }
}

class Users {
  static Map<String, User> users = {};
}
