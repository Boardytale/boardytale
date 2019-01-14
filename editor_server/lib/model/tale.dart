import 'package:editor_server/editor_server.dart';

class Tale extends ManagedObject<_Tale> implements _Tale {}

class _Tale {
  @primaryKey
  String id;

  @Column()
  String name;

  @Column()
  String authorEmail;

  @Column(defaultValue: 'false')
  bool compiled;

  @Column()
  Document lobbyTale;

  @Column(defaultValue: '0')
  int taleDataVersion;

  @Column(defaultValue: '0')
  int taleVersion;

  @Column()
  Document taleData;
}