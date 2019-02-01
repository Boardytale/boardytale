import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:shared/model/model.dart';

@Injectable()
class CreateGameService {
  final GatewayService gatewayService;

  BehaviorSubject<List<LobbyTale>> onStateChanged =
      BehaviorSubject<List<LobbyTale>>();

  CreateGameService(this.gatewayService) {
    this.gatewayService.handlers[OnClientAction.getGamesToCreate] = setState;
  }

  void setState(ToClientMessage message) {
    onStateChanged.add(message.getGamesToCreateMessage.games);
  }
}
