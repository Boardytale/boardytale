library user_server;
import 'dart:io';
import 'package:aqueduct/aqueduct.dart';
import 'package:core/configuration/configuration.dart';
import 'package:io_utils/io_utils.dart';
import 'package:user_server/channel.dart';
export 'dart:async';
export 'dart:io';

export 'package:aqueduct/aqueduct.dart';

export 'channel.dart';


void initUserServer() async{
  print("current directory ${Directory.current.path}");
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();
  final app = Application<UserServerChannel>()
    ..options.port = boardytaleConfiguration.userServer.uris.first.port.toInt();

  await app.start(numberOfInstances: 1);
}
