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
  BehaviorSubject<bool> onWorldLoaded = BehaviorSubject();
  BehaviorSubject<shared.WorldCreateEnvelope> onTaleLoaded = BehaviorSubject();
  BehaviorSubject<List<ClientPlayer>> playersOnMove = BehaviorSubject(seedValue: null);

  ClientPlayer get currentPlayer => appService.currentPlayer;
  BehaviorSubject<shared.ClientTaleData> clientTaleData = BehaviorSubject();
  ReplaySubject<EnhancedUnitCreateOrUpdateAction> unitCreateOrUpdateAction = ReplaySubject();
  BehaviorSubject<shared.Banter> currentBanter = BehaviorSubject();
  List<shared.Banter> _banterQueue = [];

  GameService(this.gatewayService, this.settings, this.appService) {
    gatewayService.handlers[shared.OnClientAction.taleData] = handleTaleData;
    gatewayService.handlers[shared.OnClientAction.playersOnMove] = handlePlayersOnMove;
    gatewayService.handlers[shared.OnClientAction.showBanter] = handleShowBanter;
  }

  void handleShowBanter(shared.ToClientMessage message) {
    addBanter(message.getBanter);
  }

  void addBanter(shared.Banter banter) {
    if(banter == null){
      if(_banterQueue.isNotEmpty){
        addBanter(_banterQueue.removeAt(0));
      }
      return;
    }
    if (currentBanter.value == null) {
      currentBanter.add(banter);
      Future.delayed(Duration(milliseconds: banter.milliseconds)).then((_){
        currentBanter.add(null);
        addBanter(null);
      });
    } else {
      _banterQueue.add(banter);
    }
  }

  void handleTaleData(shared.ToClientMessage message) {
    clientTaleData.add(message.getTaleDataMessage.data);
  }

  void handlePlayersOnMove(shared.ToClientMessage message) {
    setPlayersOnMoveByIds(message.getPlayersOnMove.playerOnMoveIds);
  }

  void setPlayersOnMoveByIds(Iterable<String> ids) {
    if (ids == null) {
      playersOnMove.add(null);
    } else {
      playersOnMove.add(ids.map((String playerId) {
        return appService.players[playerId];
      }).toList());
    }
  }
}

class EnhancedUnitCreateOrUpdateAction {
  shared.UnitCreateOrUpdateAction action;
  ClientUnit unit;
}
