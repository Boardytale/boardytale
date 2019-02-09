import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:shared/model/model.dart';

@Injectable()
class LobbyService {
  final GatewayService gatewayService;
  BehaviorSubject<List<LobbyTale>> onLobbyStateChanged = BehaviorSubject<List<LobbyTale>>(seedValue: []);

  LobbyService(this.gatewayService){
    this.gatewayService.handlers[OnClientAction.refreshLobbyList] = setState;
  }

  void setState(ToClientMessage message){
    onLobbyStateChanged.add(message.refreshLobbyListMessage.lobbies);
  }
}
