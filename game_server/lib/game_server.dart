library game_server;

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

part 'server_gateway.dart';

part 'package:game_server/model/player.dart';

part 'package:game_server/model/lobby.dart';

part 'package:game_server/model/communication.dart';

part 'package:game_server/model/tale.dart';
part 'package:game_server/model/tale/tale_action.dart';
part 'package:game_server/model/tale_state.dart';
part 'package:game_server/model/world.dart';
part 'package:game_server/model/unit.dart';
part 'package:game_server/model/heroes.dart';
part 'package:game_server/model/abilities/ability.dart';
part 'package:game_server/model/abilities/move.dart';
part 'package:game_server/model/abilities/attack.dart';
part 'package:game_server/model/abilities/shoot.dart';
part 'package:game_server/model/server_triggers.dart';
part 'package:game_server/model/server_tale_events.dart';

part 'package:game_server/services/player_service.dart';

part 'package:game_server/services/create_game.dart';

part 'package:game_server/services/lobby_service.dart';

part 'package:game_server/services/navigation_service.dart';

part 'package:game_server/services/init_service.dart';

part 'package:game_server/services/game_service.dart';

part 'package:game_server/services/intention_service.dart';

BoardytaleConfiguration config;

final PlayerService playerService = PlayerService();
final LobbyService lobbyService = LobbyService();
final CreateGameService createGameService = CreateGameService();
final ServerGateway gateway = ServerGateway();
final InitGameService initService = InitGameService();
final NavigationService navigationService = NavigationService();
final GameService gameService = GameService();
final IntentionService intentionService = IntentionService();

ServerGateway initServer(BoardytaleConfiguration configInput) {
  config = configInput;
  // trigger constructors
  playerService;
  lobbyService;
  createGameService;
  initService;
  navigationService;
  gameService;
  intentionService;
  return gateway;
}
