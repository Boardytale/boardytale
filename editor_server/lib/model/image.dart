import 'package:editor_server/model/tag.dart';
import 'package:editor_server/editor_server.dart';
import 'package:core/model/model.dart';

class Image extends ManagedObject<_Image> implements _Image {}

class _Image {
  @primaryKey
  int id;

  @Column()
  String name;

  @Column()
  String authorEmail;

  @Column()
  ImageType imageType;

  @Column(defaultValue: '0')
  int imageDataVersion;

  /// used as a cache invalidate control mechanism. It is possible to recompile tale checking for changes.
  @Column(defaultValue: '0')
  int imageVersion;

  /// match to class model.Image
  @Column()
  Document imageData;

  ManagedSet<TagToImage> tags;
}

class TagToImage extends ManagedObject<_TagToImage> implements _TagToImage {}

class _TagToImage {
  @Column(autoincrement: true, primaryKey: true)
  int id;

  @Relate(#images)
  Tag tag;

  @Relate(#tags)
  Image image;
}
