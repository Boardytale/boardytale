library tale_service;

import 'dart:async';

import 'package:angular/core.dart';
import 'package:game_client/src/game/model/model.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:shared/model/model.dart' as shared;

@Injectable()
class GameService {
  ClientWorld world;
  SettingsService settings;
  GatewayService gatewayService;
  Stream<ClientWorld> get onWorldLoaded => _onWorldLoaded.stream;
  StreamController<ClientWorld> _onWorldLoaded = StreamController();

  GameService(this.gatewayService, this.settings) {
    gatewayService.handlers[shared.OnClientAction.taleData] = handleTaleData;
  }

  void handleTaleData(shared.ToClientMessage message) {
    shared.ClientTaleData clientTaleData = message.getTaleDataMessage.data;
    ClientTale tale = ClientTale.fromClientTaleData(clientTaleData, settings);
    world = tale.world;
    this._onWorldLoaded.add(world);
  }
}
