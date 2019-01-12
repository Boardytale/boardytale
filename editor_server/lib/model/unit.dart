import 'package:editor_server/editor_server.dart';

class UnitType extends ManagedObject<_UnitType> implements _UnitType {}

class _UnitType {
  @Column(primaryKey: true)
  String id;

  @Column()
  String authorEmail;

  @Column(defaultValue: 'false')
  bool compiled;

  @Column(defaultValue: '0')
  int unitTypeDataVersion;

  /// used as a cache invalidate control mechanism. It is possible to recompile tale checking for changes.
  @Column(defaultValue: '0')
  int unitTypeVersion;

  @Column()
  Document unitTypeData;
}