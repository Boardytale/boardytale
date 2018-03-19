import "dart:io";

//const bool KEEP_COMMENTS = true;

void main() {
  String compiled = "";
  String completeString = (new File("reference/complete.json")).readAsStringSync();
  List<String> blocks = completeString.split("@");
  compiled += blocks.first;
  int failures = 0;
  for (int i = 1; i < blocks.length; i++) {
    String identifier = blocks[i].split("\r").first;
    File file = new File("reference/" + identifier + ".json");
    if (file.existsSync()) {
      String included = file.readAsStringSync().replaceFirst("{", "");
      included = included.replaceFirst("}", "", included.lastIndexOf("}")-1);
      compiled += "\r";
      compiled += included;
      compiled += "\r";
      compiled += blocks[i].replaceFirst(identifier, "");
    } else {
      failures++;
      print("${identifier} not found");
      compiled+="!file not found\r//";
      compiled+="        @";
      compiled+=blocks[i];
    }
  }

  while(compiled.contains("\n")){
    compiled = compiled.replaceAll("\n", "\r");
  }
  while(compiled.contains("\r\r")){
    compiled = compiled.replaceAll("\r\r", "\r");
  }
  print("inluded ${blocks.length-failures}/${blocks.length} files.");
  (new File("reference/generated_invalid_with_cmt.json")).writeAsStringSync(compiled);

  blocks = compiled.split("//");
  compiled = blocks[0];
  for (int i = 1; i < blocks.length; i++) {
    String comment = blocks[i].split("\r").first+"\r";
    compiled+=blocks[i].replaceFirst(comment, "");
  }
  blocks = compiled.split("/*");
  compiled = blocks[0];
  for (int i = 1; i < blocks.length; i++) {
    String comment = blocks[i].split("*/").first+"*/";
    compiled+=blocks[i].replaceFirst(comment, "");
  }
  while(compiled.contains("\n")){
    compiled = compiled.replaceAll("\n", "\r");
  }
  while(compiled.contains("\r\r")){
    compiled = compiled.replaceAll("\r\r", "\r");
  }
  (new File("reference/generated_invalid.json")).writeAsStringSync(compiled);
}