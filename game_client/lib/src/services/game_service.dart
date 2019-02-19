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
  ClientWorld world;
  SettingsService settings;
  AppService appService;
  GatewayService gatewayService;

  Stream<ClientWorld> get onWorldLoaded => _onWorldLoaded.stream;
  StreamController<ClientWorld> _onWorldLoaded = StreamController();
  ClientTale tale;

  GameService(this.gatewayService, this.settings, this.appService) {
    gatewayService.handlers[shared.OnClientAction.taleData] = handleTaleData;
  }

  void handleTaleData(shared.ToClientMessage message) {
    shared.ClientTaleData clientTaleData = message.getTaleDataMessage.data;
    tale = ClientTale.fromClientTaleData(clientTaleData, settings);
    tale.players.forEach((String id, shared.Player player) {
      appService.players[id] = Player()
        ..sharedPlayer = player
//        ..isMe =
      ;
    });
    world = tale.world;
    this._onWorldLoaded.add(world);
  }
}
