import 'package:hero_server/hero_server.dart';
import 'package:core/configuration/configuration.dart';
import 'package:io_utils/io_utils.dart';

main() async {
  final BoardytaleConfiguration config = getConfiguration();
  HeroServer(config);
}
