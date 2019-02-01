import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/model/model.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:shared/model/model.dart';

@Injectable()
class LobbyService {

  final GatewayService gatewayService;

  BehaviorSubject<ClientGameState> onLobbyStateChanged = BehaviorSubject<ClientGameState>();

  LobbyService(this.gatewayService){
    this.gatewayService.handlers[OnClientAction.refreshLobbyList] = setState;
  }

  void setState(ToClientMessage message){

  }
}
