import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/hero_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:core/model/model.dart' as core;

@Component(
    selector: 'user-panel',
    directives: [coreDirectives, formDirectives],
    templateUrl: "user_panel_component.html",
    changeDetection: ChangeDetectionStrategy.OnPush)
class UserPanelComponent {
  final ChangeDetectorRef changeDetector;
  final HeroService heroService;
  AppService appService;
  SettingsService settingsService;
  GatewayService gateway;
  String name;
  bool saved = false;
  List<core.GameHeroEnvelope> myHeroes;
  List<core.GameHeroEnvelope> heroesToCreate;
  String message = null;
  bool showSelectHeroMessage = false;

  UserPanelComponent(
    this.appService,
    this.changeDetector,
    this.settingsService,
    this.gateway,
    this.heroService,
  ) {
    appService.currentUser.listen((onData) {
      name = onData.name;
      changeDetector.markForCheck();
    });
    name = appService.currentUser.value?.name;

    getHeroesToCreate();
    refreshMyHeroes();
  }

  void refreshMyHeroes() async {
    myHeroes = await heroService.getMyHeroes();
    if (myHeroes.isNotEmpty) {
      appService.currentUser.add(appService.currentUser.value..hasHero = true);
      showSelectHeroMessage = false;
    } else {
      showSelectHeroMessage = true;
    }
    changeDetector.markForCheck();
  }

  void createHero(core.GameHeroEnvelope envelope) async {
    core.CreateHeroData createMessage = core.CreateHeroData();

    createMessage
      ..name = envelope.name
      ..innerToken = appService.currentUser.value.innerToken
      ..typeName = envelope.type.name;

    core.ToUserServerMessage message =
        await gateway.toUserServerMessage(core.ToUserServerMessage.createCreateHeroData(createMessage));
    if (message != null) {
      core.CreateHeroData createdHero = message.getCreateHeroData;
      refreshMyHeroes();
      print(createdHero.name);
    }
    changeDetector.markForCheck();
  }

  void getHeroesToCreate() async {
    core.ToUserServerMessage message =
        await gateway.toUserServerMessage(core.ToUserServerMessage.createRequestForListOfDefaultHeroesToCreate());
    heroesToCreate = message.getListOfHeroes.responseHeroes;
    changeDetector.markForCheck();
  }

  void save() async {
    core.ToUserServerMessage message =
        await gateway.toUserServerMessage(core.ToUserServerMessage.createUpdateUser(core.User()
          ..name = name
          ..innerToken = appService.currentUser.value.innerToken));
    appService.currentUser.add(message.getUpdateUser);
    saved = true;
    changeDetector.markForCheck();
    await Future.delayed(Duration(seconds: 3));
    saved = false;
    changeDetector.markForCheck();
  }

  void goToHeroPanel(core.GameHeroEnvelope hero) {
    appService.currentHero = hero;
    gateway.toGameServerMessage(core.ToGameServerMessage.createGoToState(core.GameNavigationState.heroPanel));
  }
}
