part of model;

@JsonSerializable(nullable: false)
class User {
  String id;
  String name;
}

class Users {
  static Map<String, User> users = {};
}
