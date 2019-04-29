import 'dart:convert';
import 'dart:async';
import 'dart:math' as math;
import 'dart:io' as io;
import 'package:io_utils/io_utils.dart';
import 'package:io_utils/aqueduct/wraps.dart';
import 'package:http/http.dart' as http;
import 'package:core/model/model.dart' as core;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:core/configuration/configuration.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger_server/logger.dart';

main() {
  //boardytale.vserver.cz
  io.WebSocket.connect("ws://boardytale.vserver.cz:80/").then((io.WebSocket socket) {
    socket.add(json.encode(core.ToGameServerMessage.init("aaa").toJson()));
    socket.listen((dynamic aiServerData) {
      String messageString = aiServerData.toString();
      print(messageString);
    });
  });
}
