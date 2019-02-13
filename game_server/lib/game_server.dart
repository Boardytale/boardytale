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
part 'package:game_server/model/game_controller.dart';
part 'package:game_server/model/communication.dart';

part 'controller/init.dart';
part 'controller/navigation.dart';
part 'controller/create_lobby.dart';

part 'package:game_server/services/player_service.dart';
part 'package:game_server/services/create_game.dart';
part 'package:game_server/services/lobby_service.dart';

final PlayerService playerService = PlayerService();
final LobbyService lobbyService = LobbyService();
final CreateGameService createGameService = CreateGameService();
BoardytaleConfiguration config;
ServerGateway gateway = ServerGateway();

InitGameController initGameController = InitGameController();
NavigationController navigationController = NavigationController();
CreateLobbyController createLobbyController = CreateLobbyController();


ServerGateway initServer(BoardytaleConfiguration configInput){
  config = configInput;
  return gateway;
}
