library state_service;

import 'dart:async';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/services/create_game_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:shared/model/model.dart' as shared;

@Injectable()
class AppService {
  shared.Lang language = shared.Lang.en;
  BehaviorSubject<shared.User> currentUser = BehaviorSubject<shared.User>(seedValue: null);
  BehaviorSubject<Null> destroyCurrentTale = BehaviorSubject<Null>();
  Map<shared.GameNavigationState, ClientGameState> states = {
    shared.GameNavigationState.loading: ClientGameState()
      ..name = shared.GameNavigationState.loading
      ..showCreateGameButton = false,
    shared.GameNavigationState.createGame: ClientGameState()
      ..name = shared.GameNavigationState.createGame
      ..showCreateGameButton = false,
    shared.GameNavigationState.findLobby: ClientGameState()
      ..name = shared.GameNavigationState.findLobby
      ..showCreateGameButton = true,
    shared.GameNavigationState.inGame: ClientGameState()
      ..name = shared.GameNavigationState.inGame
      ..showCreateGameButton = false,
    shared.GameNavigationState.inLobby: ClientGameState()
      ..name = shared.GameNavigationState.inLobby
      ..showCreateGameButton = false,
  };

  Map<String, ClientPlayer> players = {};
  Map<String, shared.AiGroup> aiGroups = {};
  ClientPlayer currentPlayer;
  SettingsService settings;
  StreamController<Map> _onAlert = StreamController<Map>();
  Stream<Map> get onAlert => _onAlert.stream;
  BehaviorSubject<ClientGameState> navigationState =
      BehaviorSubject<ClientGameState>();

  final GatewayService gatewayService;
  // for initialize lobbies handler
  LobbyService lobbyService;
  CreateGameService createGameService;

  AppService(
      this.settings,
      this.gatewayService,
      this.lobbyService,
      this.createGameService) {
    navigationState.add(states[shared.GameNavigationState.loading]);
    this.gatewayService.handlers[shared.OnClientAction.setNavigationState] = setState;
    this.gatewayService.handlers[shared.OnClientAction.setCurrentUser] = setUser;
  }

  void setState(shared.ToClientMessage message) {
    navigationState.add(states[message.navigationStateMessage.newState]);
    if(message.navigationStateMessage.destroyCurrentTale){
      destroyCurrentTale.add(null);
    }
  }

  void setUser(shared.ToClientMessage message) {
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

  void goToState(shared.GameNavigationState newState) {
    gatewayService.sendMessage(shared.ToGameServerMessage.fromGoToState(newState));
  }
}

class ClientGameState {
  shared.GameNavigationState name;
  bool showCreateGameButton;
}
