library tale_service;

import 'dart:async';

import 'package:angular/core.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared/model/model.dart' as shared;

@Injectable()
class GameService {
  SettingsService settings;
  AppService appService;
  GatewayService gatewayService;
  BehaviorSubject<bool> showCoordinateLabels = BehaviorSubject<bool>(seedValue: false);
  Map<String, shared.AiGroup> aiGroups = {};
  BehaviorSubject<ClientWorldService> onWorldLoaded = BehaviorSubject();
  BehaviorSubject<List<ClientPlayer>> playersOnMove = BehaviorSubject(seedValue: null);
  ClientPlayer get currentPlayer => appService.currentPlayer;
  shared.ClientTaleData clientTaleData;

  GameService(this.gatewayService, this.settings, this.appService) {
    gatewayService.handlers[shared.OnClientAction.taleData] = handleTaleData;
    gatewayService.handlers[shared.OnClientAction.playersOnMove] = handlePlayersOnMove;
  }

  void handleTaleData(shared.ToClientMessage message) {
    clientTaleData = message.getTaleDataMessage.data;
  }

  void handlePlayersOnMove(shared.ToClientMessage message) {
    setPlayersOnMoveByIds(message.getPlayersOnMove.playerOnMoveIds);
  }

  void setPlayersOnMoveByIds(Iterable<String> ids){
    if(ids == null){
      playersOnMove.add(null);
    }else{
      playersOnMove.add(ids.map((String playerId){
        return appService.players[playerId];
      }).toList());
    }
  }
}
