library state_service;

import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/model/model.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:game_client/src/world/model/model.dart';
import 'package:shared/model/model.dart';

@Injectable()
class StateService {
  bool isUserSignedIn = false;
  User loggedUser;
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
  };
  GameNavigationState currentStateName = GameNavigationState.loading;

  Stream get onWorldLoaded => _onWorldLoaded.stream;
  StreamController _onWorldLoaded = StreamController();
  ClientTale tale;
  int teamPlaying = 1;
  SettingsService settings;
  StreamController<Map> _onAlert = StreamController<Map>();

  Stream<Map> get onAlert => _onAlert.stream;
  final GatewayService gatewayService;

  BehaviorSubject<ClientGameState> onNavigationStateChanged = BehaviorSubject<ClientGameState>();

  StateService(this.settings, this.gatewayService){
    onNavigationStateChanged.add(states[GameNavigationState.loading]);
    this.gatewayService.handlers[OnClientAction.setNavigationState] = setState;
  }

  void worldIsLoaded() {
    this._onWorldLoaded.add(null);
  }

  void setState(ToClientMessage message){
    this.currentStateName = message.navigationStateMessage.newState;
    onNavigationStateChanged.add(states[currentStateName]);
  }

//  void loadTale(String taleId) {
//    HttpRequest.getString("http://localhost:8086/tales/$taleId").then(loadTaleFromData);
//  }
//
//  void loadTaleFromData(String source) {
//    Map data = parseJsonMap(source);
//    tale = TaleAssetsPack.unpack(data, new ClientInstanceGenerator());
//    (tale.world as ClientWorld).init(this, settings);
//    onTaleLoaded.notify();
//  }
//
  void alertError(String text) {
    _onAlert.add({"text": text, "type": "error"});
  }

  void alertWarning(String text) {
    _onAlert.add({"text": text, "type": "warning"});
  }

  void alertNote(String text) {
    _onAlert.add({"text": text, "type": "note"});
  }

  void goToState(GameNavigationState newState){
    gatewayService.sendMessage(ToGameServerMessage.fromGoToState(newState));
  }
}
