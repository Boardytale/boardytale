import 'package:user_server/user_server.dart';

class User extends ManagedObject<_User> implements _User {}

class _User {
  @Column(autoincrement: true, primaryKey: true)
  int id;

  @Column(unique: true)
  String email;

  @Column(unique: true)
  String innerToken;

  @Column(unique: false, defaultValue: null, nullable: true)
  String name;

  ManagedSet<Hero> heroes;
}

class Hero extends ManagedObject<_Hero> implements _Hero {}

class _Hero {
  @Column(autoincrement: true, primaryKey: true)
  int heroId;

  @Column()
  int level;

  @Column(defaultValue: "0")
  int dataFormatVersion;

  @Column()
  Document heroData;

  @Relate(#heroes, isRequired: true, onDelete: DeleteRule.cascade)
  User user;

  ManagedSet<HeroAfterGameGain> gains;
}

class HeroAfterGameGain extends ManagedObject<_HeroAfterGameGain> implements _HeroAfterGameGain {}

class _HeroAfterGameGain {
  @Column(autoincrement: true, primaryKey: true)
  int gainId;

  @Column(defaultValue: "0")
  int dataFormatVersion;

  @Column()
  Document gainData;

  @Relate(#gains, isRequired: true, onDelete: DeleteRule.cascade)
  Hero hero;
}
