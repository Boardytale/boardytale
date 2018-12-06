part of model;

@JsonSerializable(nullable: false)
@GenerateTypescript()
class User {
  String id;
  String name;
}

class Users {
  static Map<String, User> users = {};
}
