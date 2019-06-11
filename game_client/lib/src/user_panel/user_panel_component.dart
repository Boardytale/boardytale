import 'dart:convert';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:http/http.dart' as http;
import 'package:core/model/model.dart' as core;

@Component(
    selector: 'user-panel',
    directives: [coreDirectives, formDirectives],
    templateUrl: "user_panel_component.html",
    changeDetection: ChangeDetectionStrategy.OnPush)
class UserPanelComponent {
  final ChangeDetectorRef changeDetector;
  AppService appService;
  SettingsService settingsService;
  GatewayService gateway;
  String name;
  final http.Client _http;
  bool saved = false;
  List<core.GameHeroCreateEnvelope> myHeroes;
  List<core.GameHeroCreateEnvelope> heroesToCreate;
  String message = null;
  bool showSelectHeroMessage = false;

  UserPanelComponent(
    this.appService,
    this.changeDetector,
    this.settingsService,
    this.gateway,
    this._http,
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
    await appService.currentUser.first;
    http.Response response = await _http.post("/userApi/toUserMessage",
        headers: {"Content-Type": "application/json"},
        body: json.encode(core.ToUserServerMessage.createRequestForMyHeroes(appService.currentUser.value.innerToken)));
    Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      core.ToUserServerMessage message = core.ToUserServerMessage.fromJson(responseBody);
      myHeroes = message.getListOfHeroesOfPlayer.responseHeroes;
      if (myHeroes.isNotEmpty) {
        appService.currentUser.add(appService.currentUser.value..hasHero = true);
        showSelectHeroMessage = false;
      }else{
        showSelectHeroMessage = true;
      }
    } else {
      message = responseBody["message"];
    }
    changeDetector.markForCheck();
  }

  void createHero(core.GameHeroCreateEnvelope envelope) async {
    core.CreateHeroData createMessage = core.CreateHeroData();

    createMessage
      ..name = envelope.name
      ..innerToken = appService.currentUser.value.innerToken
      ..typeName = envelope.type.name;

    http.Response response = await _http.post("/userApi/toUserMessage",
        headers: {"Content-Type": "application/json"},
        body: json.encode(core.ToUserServerMessage.createCreateHeroData(createMessage)));
    Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      core.ToUserServerMessage message = core.ToUserServerMessage.fromJson(responseBody);
      core.CreateHeroData createdHero = message.getCreateHeroData;
      refreshMyHeroes();
      print(createdHero.name);
    } else {
      message = responseBody["message"];
      changeDetector.markForCheck();
    }
  }

  void deleteHero(core.GameHeroCreateEnvelope envelope) async {
    //    http.Response response = await _http.post("/userApi/toUserMessage",
    //        headers: {"Content-Type": "application/json"},
    //        body: json.encode(core.ToUserServerMessage.createHero(createMessage)));
    //    Map<String, dynamic> responseBody = json.decode(response.body);
    //    if (response.statusCode == 200) {
    //      core.ToUserServerMessage message = core.ToUserServerMessage.fromJson(responseBody);
    //      core.CreateHero createdHero = message.getCreateHeroMessage;
    //      print(createdHero.name);
    //    } else {
    //      message = responseBody["message"];
    //      changeDetector.markForCheck();
    //    }
  }

  void getHeroesToCreate() async {
    http.Response response = await _http.post("/userApi/toUserMessage",
        headers: {"Content-Type": "application/json"},
        body: json.encode(core.ToUserServerMessage.createRequestForListOfDefaultHeroesToCreate()));
    core.ToUserServerMessage message = core.ToUserServerMessage.fromJson(json.decode(response.body));
    heroesToCreate = message.getListOfHeroes.responseHeroes;
    changeDetector.markForCheck();
  }

  void save() async {
    http.Response loginResponse = await _http.post("/userApi/renameUser",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"name": name, "innerToken": appService.currentUser.value.innerToken}));
    core.User currentUser = core.User.fromGoogleJson(json.decode(loginResponse.body));
    appService.currentUser.add(currentUser);
    saved = true;
    changeDetector.markForCheck();
    await Future.delayed(Duration(seconds: 3));
    saved = false;
    changeDetector.markForCheck();
  }
}
