part of tales_compiler;


Map<String, Image> loadImages(Map fileMap) {
  Map<String, String> images = fileMap["images"];
  Map<String, Image> out = {};
  images.forEach((k, v) {
    Map imageData = JSON.decode(v);
    Image image = new Image()..fromMap(imageData);
    int dataRef = imageData["dataRef"];
    out[image.id] = image;
    if(dataRef != null){
      Map<String, String> sources = fileMap["imagesSources"];
      List<String> key = sources.keys.where(
              (String key)=>key.startsWith("${dataRef}-")
      ).toList();
      if(key.length!=1){
        throw "source image does not exist";
      }
      image.data = sources[key.first];
    }else if(image.imageSrc == null){
      throw "image source or data must be defined";
    }
  });
  return out;
}

//
//Image createImageClassWrapperFromBase64(String filename, String data) {
//  Image out = new Image();
//
//  if (filename.contains(".json")) {
//    filename = filename.replaceAll(".json", "");
//  }
//
//  int index = filename.indexOf("-");
//  if (index == -1) {
//    throw "$filename: Image name must be prefixed by id foolowed by -";
//  }
//  out.id = int.parse(filename.substring(0, index), onError: (_) {
//    throw "$filename: Image name must be prefixed by id foolowed by -";
//  });
//  out.name = filename.substring(index + 1).replaceAll(".png", "");
//  out.data = data;
//  out.published = true;
//  image_lib.Image image = image_lib.decodePng(
//      BASE64.decode(data.replaceFirst("data:image/png;base64,", "")));
//  out.width = image.width;
//  out.height = image.height;
//  return out;
//}