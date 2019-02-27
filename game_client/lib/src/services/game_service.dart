library tale_service;

import 'dart:async';

import 'package:angular/core.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:shared/model/model.dart' as shared;

@Injectable()
class GameService {
  ClientWorldService world;
  SettingsService settings;
  AppService appService;
  GatewayService gatewayService;

  Stream<ClientWorldService> get onWorldLoaded => _onWorldLoaded.stream;
  StreamController<ClientWorldService> _onWorldLoaded = StreamController();
  ClientTaleService tale;

  GameService(this.gatewayService, this.settings, this.appService, this.tale) {
    gatewayService.handlers[shared.OnClientAction.taleData] = handleTaleData;
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
    world = tale.world;
    this._onWorldLoaded.add(world);
  }
}
