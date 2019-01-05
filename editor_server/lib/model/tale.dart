import 'package:editor_server/editor_server.dart';
import 'package:shared/model/model.dart';

class Tale extends ManagedObject<_Tale> implements _Tale {}

class _Tale {
  @Column(primaryKey: true)
  String id;

  @Column()
  String authorEmail;

  @Column()
  Document lobbyTale;

  @Column(defaultValue: '0')
  int taleDataVersion;

  @Column(defaultValue: '0')
  int taleVersion;

  @Column()
  Document taleData;
}