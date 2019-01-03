part of model;

@JsonSerializable(nullable: false)
@Typescript()
class User {
  String id;
  String name;
}

class Users {
  static Map<String, User> users = {};
}
