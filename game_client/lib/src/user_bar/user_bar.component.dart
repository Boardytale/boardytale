import 'dart:convert';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:ng2_g_signin/ng2_g_signin.dart';
import 'package:http/http.dart' as http;
import 'package:shared/model/model.dart' as model;
import 'package:shared/model/model.dart';

@Component(
    selector: 'user-bar',
    template: '''
      <google-signin 
      *ngIf="showSignInButton"
      clientId="499749973436-s5enn1mvt99c8vbjdlcm390l3a5ugna0.apps.googleusercontent.com" width="240"
               theme="dark" longTitle="true" fetchBasicProfile="true"
               (googleSigninSuccess)="onGoogleSigninSuccess"></google-signin>
       <span
       *ngIf="appService.currentUser.value != null"
       >
       Logged user: {{appService.currentUser.value?.email}}
       </span>
       
       <button
       *ngIf="appService.navigationState.value.showCreateGameButton"
       (click)="goToCreate()"
       >
         Create game
       </button>
       
      ''',
    directives: [GoogleSignin, coreDirectives],
    changeDetection: ChangeDetectionStrategy.OnPush)
class UserBarComponent {
  final http.Client _http;
  final AppService appService;
  final GatewayService gatewayService;

  bool showSignInButton = false;
  final ChangeDetectorRef _cdRef;

  UserBarComponent(this._http, this.appService, this.gatewayService, this._cdRef) {
    if (html.window.localStorage.containsKey("innerToken")) {
      gatewayService.initMessages(html.window.localStorage["innerToken"]);
    } else {
      showSignInButton = true;
    }
    appService.navigationState.listen((_) => _cdRef.markForCheck());
    appService.currentUser.listen((_) => _cdRef.markForCheck());
  }

  void onGoogleSigninSuccess(GoogleSignInSuccess event) async {
    GoogleUser googleUser = event.googleUser;
    AuthResponse response = googleUser.getAuthResponse();
    http.Response loginResponse = await _http.post("/userApi/login",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"id": response.id_token}));
    User currentUser =
        model.User.fromGoogleJson(json.decode(loginResponse.body));
    appService.currentUser.add(currentUser);
    html.window.localStorage["innerToken"] = currentUser.innerToken;
    gatewayService.initMessages(currentUser.innerToken);
    showSignInButton = false;
  }

  void signOut() {
    getAuthInstance().signOut();
    appService.currentUser.add(null);
  }

  void goToCreate() {
    appService.goToState(GameNavigationState.createGame);
  }
}
