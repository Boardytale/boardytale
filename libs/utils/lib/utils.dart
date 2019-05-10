library utils;

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

Null returnNull() => null;

void retypeMapInJsonToStringDynamic(Map originalJson, List<String> keys) {
  keys.forEach((mainKey) {
    dynamic __innerMap = originalJson[mainKey];
    if (__innerMap is Map) {
      Map<String, dynamic> output = {};
      __innerMap.keys.forEach((key) {
        output[key] = __innerMap[key];
      });
      originalJson[mainKey] = output;
    } else {
      print("Not Map under given key ${mainKey}");
    }
  });
}
