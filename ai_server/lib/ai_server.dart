library ai_server;

import 'dart:convert';
import 'dart:io' as io;
import 'package:shared/configuration/configuration.dart';
import 'package:shared/model/model.dart' as shared;

part 'server_gateway.dart';
part 'src/ai_tale.dart';

BoardytaleConfiguration config;

final ServerGateway gateway = ServerGateway();

ServerGateway initServer(BoardytaleConfiguration configInput) {
  config = configInput;
  return gateway;
}
