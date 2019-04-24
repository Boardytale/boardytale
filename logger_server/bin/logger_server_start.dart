library logger;

import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'dart:async';
import 'package:core/model/model.dart' as core;
import 'dart:convert';
import 'package:core/configuration/configuration.dart';
import 'package:io_utils/io_utils.dart';

Map<String, core.LoggerTale> loggedTales = {};
Set<String> changedTales = Set();

main() async {
  Logger();
}

class Logger {
  Logger() {
    run();
    Timer.periodic(Duration(seconds: 15), (_) {
      changedTales.forEach((taleId) {
        File("out/$taleId")
          ..createSync()
          ..writeAsString(json.encode(loggedTales[taleId].toJson()));
      });
      changedTales.clear();
    });
  }

  void run() async {
    final BoardytaleConfiguration config = getConfiguration();
    final port = config.loggerServer.uris.first.port.toInt();
    var handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(_echoRequest);

    var server = await io.serve(handler, 'localhost', port);

    // Enable content compression
    server.autoCompress = true;

    print('Serving at http://${server.address.host}:${server.port}');
  }

  Future<shelf.Response> _echoRequest(shelf.Request request) async {
    String body = await request.readAsString();
    List loggerWrap = json.decode(body);
    String taleId = loggerWrap.first;
    core.LoggerMessage message = core.LoggerMessage.fromJson(loggerWrap.last);
    changedTales.add(taleId);
    core.LoggerTale tale;
    if(loggedTales.containsKey(taleId)){
      tale = loggedTales[taleId];
    }else{
      tale = core.LoggerTale();
      loggedTales[taleId] = tale;
    }
    if(message.message == core.LoggerMessageType.initial){
      tale.initial = message.getTaleDataMessage;
    }
    if(message.message == core.LoggerMessageType.taleUpdate){
      tale.updates.add(message.getTaleUpdateMessage);
    }
    return shelf.Response.ok("");
  }
}
