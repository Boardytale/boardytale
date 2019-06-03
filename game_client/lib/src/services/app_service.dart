library state_service;

import 'dart:async';
import 'dart:html' as html;
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/services/create_game_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:core/model/model.dart' as core;

@Injectable()
class AppService {
  AppService(this.settings, this.gatewayService, this.lobbyService, this.createGameService) {
    if (html.window.localStorage.containsKey("innerToken")) {
      gatewayService.initMessages(html.window.localStorage["innerToken"]);
    } else {
      showSignInButton = true;
    }
    navigationState.add(states[core.GameNavigationState.loading]);
    this.gatewayService.handlers[core.OnClientAction.setNavigationState] = setState;
    this.gatewayService.handlers[core.OnClientAction.setCurrentUser] = setUser;
  }

  core.Lang language = core.Lang.en;
  BehaviorSubject<core.User> currentUser = BehaviorSubject<core.User>(seedValue: null);
  BehaviorSubject<Null> destroyCurrentTale = BehaviorSubject<Null>();
  Map<core.GameNavigationState, ClientGameState> states = {
    core.GameNavigationState.loading: ClientGameState()
      ..name = core.GameNavigationState.loading
      ..showCreateGameButton = false,
    core.GameNavigationState.createGame: ClientGameState()
      ..name = core.GameNavigationState.createGame
      ..showCreateGameButton = false
      ..showUserPanelButton = true,
    core.GameNavigationState.findLobby: ClientGameState()
      ..name = core.GameNavigationState.findLobby
      ..showCreateGameButton = true
      ..showUserPanelButton = true,
    core.GameNavigationState.inGame: ClientGameState()
      ..name = core.GameNavigationState.inGame
      ..showCreateGameButton = false,
    core.GameNavigationState.inLobby: ClientGameState()
      ..name = core.GameNavigationState.inLobby
      ..showCreateGameButton = false
      ..showUserPanelButton = true,
    core.GameNavigationState.userPanel: ClientGameState()
      ..name = core.GameNavigationState.userPanel
      ..showCreateGameButton = false
      ..allowedNoServer = true,
  };

  Map<String, ClientPlayer> players = {};
  Map<String, core.AiGroup> aiGroups = {};
  ClientPlayer currentPlayer;
  SettingsService settings;
  StreamController<Map> _onAlert = StreamController<Map>();

  Stream<Map> get onAlert => _onAlert.stream;
  BehaviorSubject<ClientGameState> navigationState = BehaviorSubject<ClientGameState>();
  BehaviorSubject<ClientPlayer> playerRemoved = BehaviorSubject<ClientPlayer>();

  final GatewayService gatewayService;

  // for initialize lobbies handler
  LobbyService lobbyService;
  CreateGameService createGameService;
  bool showSignInButton = false;

  void setState(core.ToClientMessage message) {
    navigationState.add(states[message.navigationStateMessage.newState]);
    if (message.navigationStateMessage.destroyCurrentTale) {
      destroyCurrentTale.add(null);
    }
  }

  void setUser(core.ToClientMessage message) {
    currentUser.add(message.getCurrentUser.user);
    if (message.getCurrentUser.user == null) {
      showSignInButton = true;
    }
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

  void goToState(core.GameNavigationState newState) {
    gatewayService.sendMessage(core.ToGameServerMessage.fromGoToState(newState));
  }

  void noServerGoToState(core.GameNavigationState newState) {
    ClientGameState state = states[newState];
    if (state.allowedNoServer) {
      navigationState.add(state);
    } else {
      throw "This state has to be sent to server";
    }
  }

  void removePlayerById(String id) {
    playerRemoved.add(players.remove(id));
    players.remove(id);
  }

  String translate(Map<core.Lang, String> input) {
    if (input == null) {
      return "";
    }
    if (input.containsKey(language)) {
      return input[language];
    } else {
      return input[core.Lang.en];
    }
  }
}

class ClientGameState {
  core.GameNavigationState name;
  bool showCreateGameButton;
  bool allowedNoServer = false;
  bool showUserPanelButton = false;
}
