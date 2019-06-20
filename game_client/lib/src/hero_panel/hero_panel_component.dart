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
  List<core.HeroAfterGameGain> gains;
  Map<String, core.ItemEnvelope> gainItems;

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
      getHeroDetail();
    }
    heroService.currentHero.listen((_){
      changeDetector.markForCheck();
    });
  }

  core.GameHeroEnvelope get selectedHero => appService.currentHero;

  void getMyHeroes() async {
    myHeroes = await heroService.getMyHeroes();
    changeDetector.markForCheck();
  }

  void selectHero(core.GameHeroEnvelope hero) {
    appService.currentHero = hero;
    getHeroDetail();
    changeDetector.markForCheck();
  }

  void getHeroDetail() async {
    await appService.currentUser.first;
    core.ToUserServerMessage message = await gateway.toUserServerMessage(
        core.ToUserServerMessage.createGetHeroDetail(appService.currentUser.value.innerToken, selectedHero.id));
    core.GetHeroDetail detail = message.getHeroDetail;
    heroEnvelope = detail.responseHero;
    gainItems = detail.gainItems;
    gains = detail.gains;
    heroService.currentHero.add(core.Hero(heroEnvelope));
    // TODO: remove after debugging
    hero.updateType();
    changeDetector.markForCheck();
  }

  void save() {}
}
