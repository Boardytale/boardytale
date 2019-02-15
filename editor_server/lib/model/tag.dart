import 'package:editor_server/editor_server.dart';
import 'package:editor_server/model/image.dart';

class Tag extends ManagedObject<_Tag> implements _Tag {}

class _Tag {
  @Column(autoincrement: true, primaryKey: true)
  int id;

  @Column()
  String tag;

  ManagedSet<TagToImage> images;
}
