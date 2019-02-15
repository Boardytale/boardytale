import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:shared/model/model.dart';

@Injectable()
class LobbyService {
  final GatewayService gatewayService;
  BehaviorSubject<List<OpenedLobby>> lobbies =
      BehaviorSubject<List<OpenedLobby>>(seedValue: []);
  BehaviorSubject<OpenedLobby> openedLobby = BehaviorSubject<OpenedLobby>();

  LobbyService(this.gatewayService) {
    this.gatewayService.handlers[OnClientAction.refreshLobbyList] = setState;
    this.gatewayService.handlers[OnClientAction.openedLobbyData] =
        enteredToLobby;
  }

  void setState(ToClientMessage message) {
    lobbies.add(message.refreshLobbyListMessage.lobbies);
  }

  void enteredToLobby(ToClientMessage message) {
    openedLobby.add(message.getOpenedLobbyData.lobby);
  }
}
