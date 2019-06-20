import 'dart:html';
import 'dart:async';
import 'package:game_client/src/services/app_service.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:core/model/model.dart' as core;
import 'package:rxdart/rxdart.dart';

@Injectable()
class HeroService {
  final GatewayService gatewayService;
  final AppService appService;

  BehaviorSubject<core.Hero> currentHero = BehaviorSubject<core.Hero>(seedValue: null);

  HeroService(this.gatewayService, this.appService) {}

  Future<List<core.GameHeroEnvelope>> getMyHeroes() async {
    await appService.currentUser.first;
    core.ToUserServerMessage message = await gatewayService
        .toUserServerMessage(core.ToUserServerMessage.createRequestForMyHeroes());
    if (message.error == null) {
      return message.getListOfHeroesOfPlayer;
    } else {
      window.alert(message.error);
      return null;
    }
  }
}
