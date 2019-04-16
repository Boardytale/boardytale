import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:core/model/model.dart' as core;

@Injectable()
class LobbyService {
  final GatewayService gatewayService;
  BehaviorSubject<List<core.OpenedLobby>> lobbies = BehaviorSubject<List<core.OpenedLobby>>(seedValue: null);
  BehaviorSubject<core.OpenedLobby> openedLobby = BehaviorSubject<core.OpenedLobby>();

  LobbyService(this.gatewayService) {
    this.gatewayService.handlers[core.OnClientAction.refreshLobbyList] = setState;
    this.gatewayService.handlers[core.OnClientAction.openedLobbyData] = enteredToLobby;
  }

  void setState(core.ToClientMessage message) {
    lobbies.add(message.refreshLobbyListMessage.lobbies);
  }

  void enteredToLobby(core.ToClientMessage message) {
    openedLobby.add(message.getOpenedLobbyData.lobby);
  }
}
