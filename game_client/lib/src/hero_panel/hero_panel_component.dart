import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/hero_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:core/model/model.dart' as core;

@Component(
    selector: 'hero-panel',
    directives: [coreDirectives, formDirectives],
    templateUrl: "hero_panel_component.html",
    changeDetection: ChangeDetectionStrategy.OnPush)
class HeroPanelComponent {
  final ChangeDetectorRef changeDetector;
  final HeroService heroService;
  AppService appService;
  SettingsService settingsService;
  GatewayService gateway;
  core.Hero hero;
  List<core.GameHeroEnvelope> myHeroes;

  HeroPanelComponent(
    this.appService,
    this.changeDetector,
    this.settingsService,
    this.gateway, this.heroService,
  ) {
    if(selectedHero == null){
      getMyHeroes();
    }
  }

  core.GameHeroEnvelope get selectedHero => appService.currentHero;

  void getMyHeroes() async {
    myHeroes = await heroService.getMyHeroes();
    changeDetector.markForCheck();
  }

  void selectHero(core.GameHeroEnvelope hero){
    appService.currentHero = hero;
    changeDetector.markForCheck();
  }
}
