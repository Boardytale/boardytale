import 'dart:core';

import 'package:angular/src/core/metadata.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:core/model/model.dart' as core;
import 'package:game_client/src/hero_panel/edit_hero/edit_hero_panels/character.dart';
import 'package:game_client/src/hero_panel/edit_hero/edit_hero_panels/items.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/hero_service.dart';
import 'package:game_client/src/shared/buttoned_number_input_component.dart';

@Component(
    selector: 'shop',
    templateUrl: 'shop_component.html',
    directives: [coreDirectives, formDirectives, ButtonedNumberInputComponent, CharacterComponent, ItemsComponent])
class EditHeroComponent {
  core.Hero get hero => heroService.currentHero.value;

  final HeroService heroService;
  final GatewayService gatewayService;
  final AppService appService;

  EditHeroComponent(this.heroService, this.gatewayService, this.appService);

  core.HeroEnvelope get envelope => hero.serverState;

  bool canEquip(core.ItemEnvelope item) {
    if (item.weapon == null) {
      return true;
    }
    item.weapon.requiredAgility = item.weapon.requiredAgility ?? 0;
    item.weapon.requiredStrength = item.weapon.requiredStrength ?? 0;
    item.weapon.requiredIntelligence = item.weapon.requiredIntelligence ?? 0;

    return !(item.weapon.requiredAgility > hero.currentState.agility ||
        item.weapon.requiredIntelligence > hero.currentState.intelligence ||
        item.weapon.requiredStrength > hero.currentState.strength);
  }

  bool canSimpleEquip(core.ItemEnvelope item) {
    if (item.possiblePositions.length > 1) {
      return false;
    } else {
      return canEquip(item);
    }
  }

  List<core.ItemPosition> getMultiPositions(core.ItemEnvelope item) {
    if (item.possiblePositions.length > 1 && canEquip(item)) {
      return item.possiblePositions;
    } else {
      return [];
    }
  }

  void toInventory(core.ItemEnvelope item) {
    heroService.nextUpdate.itemManipulations.add(core.ItemManipulation()..moveToInventoryItemId = item.id);
    heroService.statsChanged();
  }

  void sellItem(core.ItemEnvelope item) {
    heroService.nextUpdate.itemManipulations.add(core.ItemManipulation()..sellItemId = item.id);
    heroService.statsChanged();
  }

  void equip(core.ItemEnvelope item, [core.ItemPosition position]) async {
    heroService.nextUpdate.itemManipulations.add(core.ItemManipulation()
      ..equipItemId = item.id
      ..equipTo = position ?? item.possiblePositions.first);
    heroService.statsChanged();
  }

  void getGain(core.HeroAfterGameGain gain) async {
    core.ToUserServerMessage message =
        await gatewayService.toUserServerMessage(core.ToUserServerMessage.createHeroUpdate(core.HeroUpdate()
          ..pickGainId = gain.id
          ..heroId = hero.id));
    core.HeroUpdate update = message.getHeroUpdate;
    heroService.setHero(update.responseHero, null);
    heroService.gains.add(heroService.gains.value..remove(gain));
  }
}
