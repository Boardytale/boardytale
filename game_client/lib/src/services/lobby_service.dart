import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:shared/model/model.dart' as shared;

@Injectable()
class LobbyService {
  final GatewayService gatewayService;
  BehaviorSubject<List<shared.OpenedLobby>> lobbies =
      BehaviorSubject<List<shared.OpenedLobby>>(seedValue: []);
  BehaviorSubject<shared.OpenedLobby> openedLobby = BehaviorSubject<shared.OpenedLobby>();

  LobbyService(this.gatewayService) {
    this.gatewayService.handlers[shared.OnClientAction.refreshLobbyList] = setState;
    this.gatewayService.handlers[shared.OnClientAction.openedLobbyData] =
        enteredToLobby;
  }

  void setState(shared.ToClientMessage message) {
    lobbies.add(message.refreshLobbyListMessage.lobbies);
  }

  void enteredToLobby(shared.ToClientMessage message) {
    openedLobby.add(message.getOpenedLobbyData.lobby);
  }
}
