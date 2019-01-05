import 'package:editor_server/editor_server.dart';
import 'package:shared/model/model.dart';

class Tale extends ManagedObject<_Tale> implements _Tale {}

class _Tale {
  @Column(primaryKey: true)
  String id;

  @Column()
  String authorEmail;

  @Column(defaultValue: '0')
  int taleDataVersion;

  /// used as a cache invalidate control mechanism. It is possible to recompile tale checking for changes.
  @Column(defaultValue: '0')
  int unitVersion;

  @Column()
  Document unitData;
}