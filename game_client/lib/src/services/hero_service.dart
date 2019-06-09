import 'dart:html';
import 'dart:async';
import 'package:game_client/src/services/app_service.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:core/model/model.dart' as core;

@Injectable()
class HeroService {
  final GatewayService gatewayService;
  final AppService appService;

  HeroService(this.gatewayService, this.appService) {}

  Future<List<core.GameHeroCreateEnvelope>> getMyHeroes() async {
    await appService.currentUser.first;
    core.ToUserServerMessage message = await gatewayService
        .toUserServerMessage(core.ToUserServerMessage.requestMyHeroes(appService.currentUser.value.innerToken));
    if (message.error == null) {
      return message.getListOfHeroesOfPlayer.responseHeroes;
    } else {
      window.alert(message.error);
      return null;
    }
  }
}
