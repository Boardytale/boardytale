library utils;

part 'notificator.dart';

String convertToCamelCase(String name) {
  String out = '';
  for (int i = 0; i < name.length; i++) {
    String char = name[i];
    if (char != "_") {
      out += char;
    } else {
      out += name[++i].toUpperCase();
    }
  }
  return out;
}