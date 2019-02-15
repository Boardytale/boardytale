library tale_service;

import 'dart:async';

import 'package:angular/core.dart';
import 'package:game_client/src/game/model/model.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:shared/model/model.dart' as shared;

@Injectable()
class GameService {
  ClientWorld world;
  GatewayService gatewayService;
  Stream get onWorldLoaded => _onWorldLoaded.stream;
  StreamController _onWorldLoaded = StreamController();

  GameService(this.gatewayService) {
    gatewayService.handlers[shared.OnClientAction.taleData] = handleTaleData;
  }

  void handleTaleData(shared.ToClientMessage message) {
    shared.ClientTaleData clientTaleData = message.getTaleDataMessage.data;
    ClientTale tale = ClientTale.fromClientTaleData(clientTaleData);
    world = ClientWorld(tale);
    this._onWorldLoaded.add(null);
  }
}
