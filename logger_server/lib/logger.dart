library hero_server;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:core/model/model.dart' as core;


class Logger {
  static log(String taleId, core.LoggerMessage message){
    var url = "http://localhost:3333/";
    http.post(url, body: json.encode([taleId, message.toJson()]));
  }
}


