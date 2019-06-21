import 'dart:core';

import 'package:angular/src/core/metadata.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:core/model/model.dart' as core;
import 'package:game_client/src/services/hero_service.dart';
import 'package:game_client/src/shared/buttoned_number_input_component.dart';

@Component(
    selector: 'character',
    templateUrl: 'character.html',
    directives: [coreDirectives, formDirectives, ButtonedNumberInputComponent])
class CharacterComponent {
  @Input()
  core.Hero hero;

  final HeroService heroService;

  CharacterComponent(this.heroService);

  core.HeroEnvelope get envelope => hero.serverState;

  int get agility => heroService.nextUpdate.agility != null ? heroService.nextUpdate.agility : envelope.agility;

  int get strength => heroService.nextUpdate.strength != null ? heroService.nextUpdate.strength : envelope.strength;

  int get intelligence =>
      heroService.nextUpdate.intelligence != null ? heroService.nextUpdate.intelligence : envelope.intelligence;

  bool get showStrAgiInt => hero.showStrAgiInt;

  bool get heroIsMidLevel => hero.isMidLevel;

  bool get heroIsHighLevel => hero.isHighLevel;

  bool get heroIsLowLevel => hero.isLowLevel;

  bool get heroIsMidOrHighLevel => hero.isMidOrHighLevel;

  bool get enablePhysicals => hero.enableAddPhysicalPoint;

  void setStrength(int newValue) {
    if (newValue > hero.serverState.strength) {
      heroService.nextUpdate.strength = newValue;
      heroService.statsChanged();
    }
  }

  void setAgility(int newValue) {
    if (newValue > hero.serverState.agility) {
      heroService.nextUpdate.agility = newValue;
      heroService.statsChanged();
    }
  }

  void setIntelligence(int newValue) {
    if (newValue > hero.serverState.intelligence) {
      heroService.nextUpdate.intelligence = newValue;
      heroService.statsChanged();
    }
  }
}
