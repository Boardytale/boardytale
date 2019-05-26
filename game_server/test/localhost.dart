import 'dart:convert';
import 'dart:io' as io;
import 'package:core/model/model.dart' as core;
import 'package:http/http.dart' as http;

main() {
 http.get("http://localhost:4201").then((data){
   print(data.body);
 });
}
