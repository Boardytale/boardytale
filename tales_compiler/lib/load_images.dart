part of tales_compiler;


Map<int, Image> loadImages(Map fileMap) {
  Map<String, String> images = fileMap["images"];
  Map<int, Image> out = {};
  images.forEach((k, v) {
    Image image = createImageClassWrapperFromBase64(k, v);
    out[image.id] = image;
  });
  return out;
}


Image createImageClassWrapperFromBase64(String filename, String data) {
  Image out = new Image();

  if (filename.contains(".json")) {
    filename = filename.replaceAll(".json", "");
  }

  int index = filename.indexOf("-");
  if (index == -1) {
    throw "$filename: Image name must be prefixed by id foolowed by -";
  }
  out.id = int.parse(filename.substring(0, index), onError: (_) {
    throw "$filename: Image name must be prefixed by id foolowed by -";
  });
  out.name = filename.substring(index + 1).replaceAll(".png", "");
  out.data = data;
  out.published = true;
  image_lib.Image image = image_lib.decodePng(
      BASE64.decode(data.replaceFirst("data:image/png;base64,", "")));
  out.width = image.width;
  out.height = image.height;
  return out;
}