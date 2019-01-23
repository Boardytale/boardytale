import 'package:io_utils/io_utils.dart';
import 'package:shared/configuration/configuration.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:game_server/channel.dart';

main() async {
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();
  final app = Application<GameServerChannel>()
    ..options.port = boardytaleConfiguration.gameServer.uris.first.port.toInt();
  await app.start(numberOfInstances: 1);
  print("Application started on port: ${app.options.port}.");
}

