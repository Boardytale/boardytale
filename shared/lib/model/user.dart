part of model;

@JsonSerializable(nullable: false)
@Typescript()
class User {
  String name;
  String email;
  String innerToken;

  static User fromJson(Map data){
    return _$UserFromJson(data);
  }

  static User fromGoogleJson(Map data){
    data["id"] = data["id"].toString();
    return _$UserFromJson(data);
  }

  Map toJson(){
    return _$UserToJson(this);
  }
}

class Users {
  static Map<String, User> users = {};
}
