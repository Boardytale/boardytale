library hero_server;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:core/model/model.dart' as core;
import 'package:logger_server/project_settings.dart';


class Logger {
  static log(String taleId, core.LoggerMessage message) async {
    var url = "http://localhost:${ProjectSettings.loggerServerPort}/";
    try{
      await http.post(url, body: json.encode([taleId, message.toJson()]));
    }catch(e){
      print("logger not working");
    }
  }
}


