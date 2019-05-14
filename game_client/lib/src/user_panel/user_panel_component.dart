import 'dart:convert';
import 'dart:async';
import 'dart:html';
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

  UserPanelComponent(
    this.appService,
    this.changeDetector,
    this.settingsService,
    this.gateway, this._http,
  ) {
    appService.currentUser.listen((onData) {
      name = onData.name;
      changeDetector.markForCheck();
    });
    name = appService.currentUser.value?.name;
  }

  void save() async {
    http.Response loginResponse = await _http.post("/userApi/renameUser",
        headers: {"Content-Type": "application/json"}, body: json.encode({"name": name, "innerToken": appService.currentUser.value.innerToken}));
    core.User currentUser = core.User.fromGoogleJson(json.decode(loginResponse.body));
    appService.currentUser.add(currentUser);
    saved = true;
    changeDetector.markForCheck();
    await Future.delayed(Duration(seconds: 3));
    saved = false;
    changeDetector.markForCheck();
  }

  void returnToAppState(){
    window.location.reload();
  }
}
