import 'package:user_server/user_server.dart';

class User extends ManagedObject<_User> implements _User {}

class _User {
  @Column(autoincrement: true, primaryKey: true)
  int id;

  @Column(unique: true)
  String email;

  @Column(unique: true)
  String innerToken;
}