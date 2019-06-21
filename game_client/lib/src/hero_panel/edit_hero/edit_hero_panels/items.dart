import 'dart:core';

import 'package:angular/src/core/metadata.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:core/model/model.dart' as core;
import 'package:game_client/src/services/hero_service.dart';
import 'package:game_client/src/shared/buttoned_number_input_component.dart';

@Component(
    selector: 'items',
    templateUrl: 'items.html',
    directives: [coreDirectives, formDirectives, ButtonedNumberInputComponent])
class ItemsComponent {
  @Input()
  core.Hero hero;

  final HeroService heroService;

  ItemsComponent(this.heroService);

  core.ItemSum get items => hero.currentState.equippedItemsSum;

  bool get showStrAgiInt => hero.showStrAgiInt;

  bool get heroIsMidLevel => hero.isMidLevel;

  bool get heroIsHighLevel => hero.isHighLevel;

  bool get heroIsLowLevel => hero.isLowLevel;

  bool get heroIsMidOrHighLevel => hero.isMidOrHighLevel;
}
