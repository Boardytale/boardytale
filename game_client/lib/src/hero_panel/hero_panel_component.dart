import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:game_client/src/hero_panel/edit_hero/edit_component.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/hero_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:core/model/model.dart' as core;

@Component(
    selector: 'hero-panel',
    exports: [TabNames],
    directives: [coreDirectives, formDirectives, EditHeroComponent],
    templateUrl: "hero_panel_component.html",
    changeDetection: ChangeDetectionStrategy.OnPush)
class HeroPanelComponent {
  final ChangeDetectorRef changeDetector;
  final HeroService heroService;
  AppService appService;
  SettingsService settingsService;
  GatewayService gateway;
  core.HeroEnvelope heroEnvelope;
  TabNames tabName = TabNames.select;

  core.Hero get hero => heroService.currentHero.value;
  List<core.GameHeroEnvelope> myHeroes;

  HeroPanelComponent(
    this.appService,
    this.changeDetector,
    this.settingsService,
    this.gateway,
    this.heroService,
  ) {
    if (selectedHero == null) {
      getMyHeroes();
    } else {
      goToHeroPanel();
      getHeroDetail();
    }
    heroService.currentHero.listen((_){
      changeDetector.markForCheck();
    });
    heroService.gains.listen((_){
      changeDetector.markForCheck();
    });
  }

  core.GameHeroEnvelope get selectedHero => appService.currentHero;


//  "goToSelectHero()">Select hero</span>
//  <span (click)="goToHeroPanel()">Hero panel</span>
//  <span (click)="goToShop()">Shop</span>
//  <span (click)="goToShelf()">

  void goToSelectHero() async {
    tabName = TabNames.select;
    getMyHeroes();
    changeDetector.markForCheck();
  }
  void goToHeroPanel() async {
    tabName = TabNames.hero;
    changeDetector.markForCheck();
  }
  void goToShop() async {
    tabName = TabNames.shop;
    changeDetector.markForCheck();
  }
  void goToShelf() async {
    tabName = TabNames.shelf;
    changeDetector.markForCheck();
  }

  void getMyHeroes() async {
    myHeroes = await heroService.getMyHeroes();
    changeDetector.markForCheck();
  }

  void selectHero(core.GameHeroEnvelope hero) {
    appService.currentHero = hero;
    getHeroDetail();
    goToHeroPanel();
  }

  void getHeroDetail() async {
    await appService.currentUser.first;
    core.ToUserServerMessage message = await gateway.toUserServerMessage(
        core.ToUserServerMessage.createGetHeroDetail(appService.currentUser.value.innerToken, selectedHero.id));
    core.GetHeroDetail detail = message.getHeroDetail;
    heroEnvelope = detail.responseHero;
    heroService.gains.add(detail.gains);
    heroService.setHero(heroEnvelope, detail.gainItems);
    changeDetector.markForCheck();
  }
}

enum TabNames{
  select,
  hero,
  shop,
  shelf
}
