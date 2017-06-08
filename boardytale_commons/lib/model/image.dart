part of model;

class Image {
  int id;
  String data;
  String imageSrc;
  double multiply = 1.0;
  int width;
  int height;
  int top = 0; // option to possible make smaller images
  int left = 0;
  String name;
  String type;
  String authorId;
  String parentId;
  bool published = false;
  Image parent;
  User author;
  double rating = 100.0;
  DateTime created;
  List<String> tags;
  Set<Image> versions = new Set<Image>();

  void fromMap(Map data) {
    dynamic __id = data["id"];
    if (__id != null){
        id = __id;
    }
    assert(id != null);
    authorId = data["authorId"];
    parentId = data["parentId"];
    rating = data["rating"];
    dynamic __created = data["created"];
    if(__created is int){
      created = new DateTime.fromMillisecondsSinceEpoch(__created);
    }
    if (data["data"] is String) {
      this.data = data["data"];
    }
    if (data["width"] is int) {
      width = data["width"];
    }
    if (data["height"] is int) {
      height = data["height"];
    }
    if (data["name"] is String) {
      name = data["name"];
    }
    if (data["type"] is String) {
      type = data["type"];
    }
    if (data["published"] is bool) {
      published = data["published"];
    }
    if (data["tags"] is List<String>) {
      tags = data["tags"];
    }
    if(data["imageSrc"] is String){
      imageSrc = data["imageSrc"];
    }
    if(data["multiply"] is num){
      multiply = data["multiply"].toDouble();
    }

    dynamic __top = data["top"];
    if(__top is int){
      top = __top;
    }
    dynamic __left = data["left"];
    if(__left is int){
      left = __left;
    }
  }

  Map toMap() {
    Map out = {};
    out["id"] = id;
    out["data"] = data;
    out["width"] = width;
    out["height"] = height;
    out["top"] = top;
    out["left"] = left;
    out["name"] = name;
    out["imageSrc"] = imageSrc;
    out["multiply"] = multiply;
    return out;
  }
}

class Images {
  static Map<String, Image> images = {};

  void fromMap(Map data) {
    data.forEach((String id, Map image) {
      images[id] = new Image()
        ..fromMap(image);
    });
    images.forEach((String id, Image image) {
      if (image.authorId != null) {
        image.author = Users.users[image.authorId];
      }
      if (image.parentId != null) {
        image.parent = images[image.parentId];
        image.parent.versions.add(image);
      }
    });
  }
}