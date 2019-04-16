import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:core/model/model.dart';

@Injectable()
class CreateGameService {
  final GatewayService gatewayService;

  BehaviorSubject<List<LobbyTale>> talesToCreate = BehaviorSubject<List<LobbyTale>>();

  CreateGameService(this.gatewayService) {
    this.gatewayService.handlers[OnClientAction.getGamesToCreate] = setState;
  }

  void setState(ToClientMessage message) {
    talesToCreate.add(message.getGamesToCreateMessage.games);
  }
}
