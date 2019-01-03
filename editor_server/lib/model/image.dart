import 'package:editor_server/model/tag.dart';
import 'package:editor_server/editor_server.dart';
import 'package:shared/model/model.dart';

class Image extends ManagedObject<_Image> implements _Image {}

class _Image {
  @Column(autoincrement: true, primaryKey: true)
  int id;

  @Column()
  String authorEmail;

  @Column()
  ImageType imageType;

  @Column(defaultValue: '0')
  int imageDataVersion;

  @Column()
  Document imageData;
}

class TagToImage extends ManagedObject<_TagToImage> implements _TagToImage {}

class _TagToImage {
  @Column(autoincrement: true, primaryKey: true)
  int id;

  @Relate(#id)
  Tag tag;

  @Relate(#id)
  Image image;
}