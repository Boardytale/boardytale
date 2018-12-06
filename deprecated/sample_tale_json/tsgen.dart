import "dart:io";

//const bool KEEP_COMMENTS = true;

void main() {
  File file = new File("temp");

  List<String> identifiers = [
    "unitTypes",
    "abilities",
    "events",
    "actions",
    "sounds",
    "images",
    "animations",
    "ais",
    "aiPlayers",
    "dialogs",
    "variables",
    "members",
  ];

  String output = "";
  String output2 = "";
  String output3 = "";
  String output4 = "";
  for(String idx in identifiers){
    String str = idx.lastIndexOf("s")==idx.length ? idx.substring(0, idx.length-1) : idx;
//    buffs: { [key: string]: IBuff | IBuffId; },
    String camel = str[0].toUpperCase()+str.substring(1);
    output += "$idx : { [key: I${camel}CustomId]: I$camel | I${camel}Id, },\r";
    output2 += "export type I${camel}CustomId = 'placeHolder1' | 'placeHolder2';\r";
    output3 += "export {I${camel}} from './$str';\r";
    output4 += "export type I${camel}Id = 'placeHolder1' | 'placeHolder2';\r";
  }
  file.writeAsStringSync(output+"\r\r"+output2+"\r\r"+output3+"\r\r"+output4);
}