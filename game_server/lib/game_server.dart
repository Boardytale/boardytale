library game_server;

import 'dart:convert';
import 'dart:async';
import 'package:io_utils/io_utils.dart';
import 'package:io_utils/aqueduct/wraps.dart';
import 'package:http/http.dart' as http;
import 'package:shared/model/model.dart' as shared;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared/configuration/configuration.dart';
import 'package:rxdart/rxdart.dart';

part 'server_gateway.dart';

part 'package:game_server/model/player.dart';

part 'package:game_server/model/lobby.dart';

part 'package:game_server/model/communication.dart';

part 'package:game_server/model/tale.dart';

part 'package:game_server/services/player_service.dart';

part 'package:game_server/services/create_game.dart';

part 'package:game_server/services/lobby_service.dart';

part 'package:game_server/services/navigation_service.dart';

part 'package:game_server/services/init_service.dart';

part 'package:game_server/services/game_service.dart';

BoardytaleConfiguration config;

final PlayerService playerService = PlayerService();
final LobbyService lobbyService = LobbyService();
final CreateGameService createGameService = CreateGameService();
final ServerGateway gateway = ServerGateway();
final InitGameService initService = InitGameService();
final NavigationService navigationService = NavigationService();
final GameService gameService = GameService();

ServerGateway initServer(BoardytaleConfiguration configInput) {
  config = configInput;
  // trigger constructors
  playerService;
  lobbyService;
  createGameService;
  initService;
  navigationService;
  gameService;
  return gateway;
}
