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
  ClientWorldService world;
  SettingsService settings;
  AppService appService;
  GatewayService gatewayService;
  BehaviorSubject<bool> showCoordinateLabels = BehaviorSubject<bool>(seedValue: false);
  Map<String, shared.AiGroup> aiGroups = {};
  Stream<ClientWorldService> get onWorldLoaded => _onWorldLoaded.stream;
  StreamController<ClientWorldService> _onWorldLoaded = StreamController();
  ClientTaleService tale;
  BehaviorSubject<List<ClientPlayer>> playersOnMove = BehaviorSubject(seedValue: null);
  BehaviorSubject<shared.AiGroup> aiGroupOnMove = BehaviorSubject(seedValue: null);

  ClientPlayer get currentPlayer => appService.currentPlayer;

  GameService(this.gatewayService, this.settings, this.appService, this.tale) {
    gatewayService.handlers[shared.OnClientAction.taleData] = handleTaleData;
    gatewayService.handlers[shared.OnClientAction.playersOnMove] = handlePlayersOnMove;
  }

  void handleTaleData(shared.ToClientMessage message) {
    shared.ClientTaleData clientTaleData = message.getTaleDataMessage.data;
    tale.fromClientTaleData(clientTaleData);
    tale.players.forEach((String id, shared.Player player) {
      ClientPlayer newPlayer = ClientPlayer()..fromSharedPlayer(player);
      appService.players[id] = newPlayer;
      if (newPlayer.id == clientTaleData.playerIdOnThisClientMachine) {
        appService.currentPlayer = newPlayer;
      }
    });
    aiGroups = clientTaleData.aiGroups;
    setPlayersOnMoveByIds(clientTaleData.playerOnMoveIds);
    setAiGroupOnMoveById(clientTaleData.aiGroupOnMove);
    world = tale.world;
    this._onWorldLoaded.add(world);
  }

  void handlePlayersOnMove(shared.ToClientMessage message) {
    setPlayersOnMoveByIds(message.getPlayersOnMove.playerOnMoveIds);
    setAiGroupOnMoveById(message.getPlayersOnMove.aiGroupOnMove);
  }

  void setPlayersOnMoveByIds(List<String> ids){
    if(ids == null){
      playersOnMove.add(null);
    }else{
      playersOnMove.add(ids.map((String playerId){
        return appService.players[playerId];
      }).toList());
    }
  }

  void setAiGroupOnMoveById(String aiGroupId) {
    aiGroupOnMove.add(aiGroups[aiGroupId]);
  }
}
