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

  /// match to class model.LobbyTale
  @Column()
  Document lobbyTale;

  @Column(defaultValue: '0')
  int taleDataVersion;

  @Column(defaultValue: '0')
  int taleVersion;

  /// match to class model.TaleEnvelope or model.TaleCompiled if ${name}Compiled
  @Column()
  Document taleData;
}
