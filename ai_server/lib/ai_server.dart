library ai_server;

import 'dart:convert';
import 'dart:io' as io;
import 'package:core/configuration/configuration.dart';
import 'package:core/model/model.dart' as core;
import 'package:web_socket_channel/web_socket_channel.dart';
part 'server_gateway.dart';
part 'src/ai_tale.dart';

BoardytaleConfiguration config;

final ServerGateway gateway = ServerGateway();

ServerGateway initServer(BoardytaleConfiguration configInput) {
  config = configInput;
  return gateway;
}
