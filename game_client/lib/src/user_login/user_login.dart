import 'dart:convert';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:http/http.dart' as http;
import 'package:ng2_g_signin/ng2_g_signin.dart';

import 'package:core/model/model.dart' as core;

@Component(
    selector: 'user-login',
    directives: [GoogleSignin, coreDirectives, formDirectives],
    styleUrls: ['user_login.css'],
    templateUrl: "user_login.html",
    changeDetection: ChangeDetectionStrategy.OnPush)
class UserLoginComponent {
  final ChangeDetectorRef changeDetector;
  final GatewayService gatewayService;
  final http.Client _http;
  AppService appService;
  SettingsService settingsService;
  GatewayService gateway;
  String name;
  bool saved = false;

  UserLoginComponent(
      this._http,
      this.appService,
      this.changeDetector,
      this.settingsService,
      this.gatewayService,
      this.gateway,
      ) {
//    appService.currentUser.listen((onData) {
//      name = onData.name;
//      changeDetector.markForCheck();
//    });
//    name = appService.currentUser.value?.name;
  }


  void onGoogleSigninSuccess(GoogleSignInSuccess event) async {
    GoogleUser googleUser = event.googleUser;
    AuthResponse response = googleUser.getAuthResponse();
    if(response.id_token ==  null){
      print("missing id_token in google auth");
      return;
    }
    http.Response loginResponse = await _http.post("/userApi/login",
        headers: {"Content-Type": "application/json"}, body: json.encode({"id": response.id_token}));
    core.User currentUser = core.User.fromGoogleJson(json.decode(loginResponse.body));
    appService.currentUser.add(currentUser);
    html.window.localStorage["innerToken"] = currentUser.innerToken;
    gatewayService.initMessages(currentUser.innerToken);
    appService.showSignInButton = false;
  }

  void createTemporaryUser() async {
    http.Response loginResponse = await _http.post("/userApi/createTemporaryUser",
        headers: {"Content-Type": "application/json"}, body: json.encode({"name": "TODO custom temp name"}));
    core.User currentUser = core.User.fromGoogleJson(json.decode(loginResponse.body));
    appService.currentUser.add(currentUser);
    html.window.localStorage["innerToken"] = currentUser.innerToken;
    gatewayService.initMessages(currentUser.innerToken);
    appService.showSignInButton = false;
  }

//
//  void save() async {
//    http.Response loginResponse = await _http.post("/userApi/renameUser",
//        headers: {"Content-Type": "application/json"}, body: json.encode({"name": name, "innerToken": appService.currentUser.value.innerToken}));
//    core.User currentUser = core.User.fromGoogleJson(json.decode(loginResponse.body));
//    appService.currentUser.add(currentUser);
//    saved = true;
//    changeDetector.markForCheck();
//    await Future.delayed(Duration(seconds: 3));
//    saved = false;
//    changeDetector.markForCheck();
//  }

//  void returnToAppState(){
//    window.location.reload();
//  }
}
