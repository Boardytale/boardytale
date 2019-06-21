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
  bool saveDisabled = true;
  core.HeroUpdate nextUpdate = core.HeroUpdate();

  BehaviorSubject<core.Hero> currentHero = BehaviorSubject<core.Hero>(seedValue: null);
  BehaviorSubject<List<core.HeroAfterGameGain>> gains = BehaviorSubject<List<core.HeroAfterGameGain>>(seedValue: null);

  Map<String, core.ItemEnvelope> get itemDB => currentHero.value.itemsData;

  int get nextArmor {
    for (int i = 0; i < core.Hero.armorStops.length; i++) {
      if (currentHero.value.currentState.armorPoints < core.Hero.armorStops[i]) {
        return core.Hero.armorStops[i];
      }
    }
    return null;
  }

  int get nextSpeed {
    for (int i = 0; i < core.Hero.speedStops.length; i++) {
      if (currentHero.value.currentState.speedPoints < core.Hero.speedStops[i]) {
        return core.Hero.speedStops[i];
      }
    }
    return null;
  }

  HeroService(this.gatewayService, this.appService) {}

  Future<List<core.GameHeroEnvelope>> getMyHeroes() async {
    await appService.currentUser.first;
    core.ToUserServerMessage message =
    await gatewayService.toUserServerMessage(core.ToUserServerMessage.createRequestForMyHeroes());
    if (message.error == null) {
      return message.getListOfHeroesOfPlayer;
    } else {
      window.alert(message.error);
      return null;
    }
  }

  void statsChanged() {
    saveDisabled = false;
    currentHero.value.recalculateSum(nextUpdate);
    currentHero.add(currentHero.value);
  }

  void discard() {
    nextUpdate = core.HeroUpdate();
    currentHero.value.recalculateSum(nextUpdate);
    currentHero.add(currentHero.value);
  }

  void setHero(core.HeroEnvelope responseHero, Map<String, core.ItemEnvelope> itemDB) {
    if (itemDB == null) {
      itemDB = this.itemDB;
    }
    responseHero.inventoryItems.forEach((item) {
      itemDB[item.id] = item;
    });
    currentHero.add(core.Hero(responseHero, itemDB));
  }

  void save() async {
    core.ToUserServerMessage message = await gatewayService
        .toUserServerMessage(core.ToUserServerMessage.createHeroUpdate(nextUpdate..heroId = currentHero.value.id));
    core.HeroUpdate update = message.getHeroUpdate;
    setHero(update.responseHero, null);
    nextUpdate = core.HeroUpdate();
    saveDisabled = true;
  }
}
