import 'dart:core';

import 'package:angular/src/core/metadata.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:core/model/model.dart' as core;
import 'package:game_client/src/hero_panel/edit_hero/edit_hero_panels/character.dart';
import 'package:game_client/src/hero_panel/edit_hero/edit_hero_panels/items.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/hero_service.dart';
import 'package:game_client/src/shared/buttoned_number_input_component.dart';

@Component(
    selector: 'edit-hero',
    templateUrl: 'edit_component.html',
    directives: [coreDirectives, formDirectives, ButtonedNumberInputComponent, CharacterComponent, ItemsComponent])
class EditHeroComponent {
  core.Hero get hero => heroService.currentHero.value;

  final HeroService heroService;
  final GatewayService gatewayService;

  EditHeroComponent(this.heroService, this.gatewayService);

  core.HeroEnvelope get envelope => hero.envelope;

  bool get showStrAgiInt => hero.showStrAgiInt;

  bool get heroIsMidLevel => hero.isMidLevel;

  bool get heroIsHighLevel => hero.isHighLevel;

  bool get heroIsLowLevel => hero.isLowLevel;

  bool get heroIsMidOrHighLevel => hero.isMidOrHighLevel;

  void save() {
    //    this.heroService.createOrEditHero(hero);
  }

  void removeWeapon() {
    //    hero.items.removeWhere((Item item) => item is Weapon);
    //    save();
  }

  void sellItem(core.ItemEnvelope item) {
    //    hero.items.removeWhere((Item value) => value == item);
    //    save();
  }

  void getGain(core.HeroAfterGameGain gain) async {
    core.ToUserServerMessage message = await gatewayService.toUserServerMessage(core.ToUserServerMessage.createHeroUpdate(core.HeroUpdate()
      ..pickGainId = gain.id
      ..heroId = hero.id));
    heroService.currentHero.add(core.Hero(message.getHeroUpdate.responseHero));
    heroService.gains.add(heroService.gains.value..remove(gain));
  }
}
