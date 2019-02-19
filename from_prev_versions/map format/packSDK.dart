import 'dart:io';

void main() {
  packSDK(null);
}

void packSDK(String directory, {bool removeComments: true}) {
  List<String> parts =
      (new File("template/complete.ts")).readAsStringSync().split("//@marker1");
  String packed = parts[1];
  List<String> lines = parts[2].split(";");
  for (String line in lines) {
    if (!line.contains("'")) continue;
    String destinationFileString =
        (new File("template/" + line.split("'")[1] + ".ts")).readAsStringSync();
    packed += "\r";
    packed += "export";
    packed += destinationFileString.split("export")[1];
    packed += "\r";
  }
  packed += parts[4];
  if (removeComments) {
    packed = packed.replaceAll("\n", "\r");
    packed = packed.replaceAll("\r\r", "\r");
    packed = packed.replaceAll("\r\r", "\r");
    packed = packed.replaceAll("\r\r", "\r");
    List<String> commentSeparated = packed.split("//");
    packed = commentSeparated.first;
    for (int i = 1; i < commentSeparated.length; i++) {
      String comment = commentSeparated[i].split("\r").first;
      packed +=
          commentSeparated[i].replaceFirst(comment, "").replaceFirst("\r", "");
    }
  }
  if (directory == null) {
    packed = packed.replaceAll("} from './storage_identifiers'",
        "} from './template/storage_identifiers'");
    new File('tale_format.ts').writeAsStringSync(packed);
  } else {
    String path = directory + "/tale_format.ts";
    new File(path).writeAsStringSync(packed);
  }
}
