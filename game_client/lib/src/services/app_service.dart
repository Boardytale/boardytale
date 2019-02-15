library state_service;

import 'dart:async';
import 'package:game_client/src/services/create_game_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/services/game_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/model/model.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:shared/model/model.dart';

@Injectable()
class AppService {
  BehaviorSubject<User> currentUser = BehaviorSubject<User>(seedValue: null);
  Map<GameNavigationState, ClientGameState> states = {
    GameNavigationState.loading: ClientGameState()
      ..name = GameNavigationState.loading
      ..showCreateGameButton = false,
    GameNavigationState.createGame: ClientGameState()
      ..name = GameNavigationState.createGame
      ..showCreateGameButton = false,
    GameNavigationState.findLobby: ClientGameState()
      ..name = GameNavigationState.findLobby
      ..showCreateGameButton = true,
    GameNavigationState.inGame: ClientGameState()
      ..name = GameNavigationState.inGame
      ..showCreateGameButton = false,
    GameNavigationState.inLobby: ClientGameState()
      ..name = GameNavigationState.inLobby
      ..showCreateGameButton = false,
  };

  SettingsService settings;
  StreamController<Map> _onAlert = StreamController<Map>();
  Stream<Map> get onAlert => _onAlert.stream;
  BehaviorSubject<ClientGameState> navigationState =
      BehaviorSubject<ClientGameState>();

  final GatewayService gatewayService;
  // for initialize lobbies handler
  LobbyService lobbyService;
  CreateGameService createGameService;
  GameService gameService;

  AppService(
      this.settings,
      this.gatewayService,
      this.lobbyService,
      this.gameService,
      this.createGameService) {
    navigationState.add(states[GameNavigationState.loading]);
    this.gatewayService.handlers[OnClientAction.setNavigationState] = setState;
    this.gatewayService.handlers[OnClientAction.setCurrentUser] = setUser;
  }

  void setState(ToClientMessage message) {
    navigationState.add(states[message.navigationStateMessage.newState]);
  }

  void setUser(ToClientMessage message) {
    currentUser.add(message.getCurrentUser.user);
  }

  void alertError(String text) {
    _onAlert.add({"text": text, "type": "error"});
  }

  void alertWarning(String text) {
    _onAlert.add({"text": text, "type": "warning"});
  }

  void alertNote(String text) {
    _onAlert.add({"text": text, "type": "note"});
  }

  void goToState(GameNavigationState newState) {
    gatewayService.sendMessage(ToGameServerMessage.fromGoToState(newState));
  }
}
