import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/state_service.dart';
import 'package:ng2_g_signin/ng2_g_signin.dart';
import 'package:http/http.dart' as http;
import 'package:shared/model/model.dart' as model;
import 'package:shared/model/model.dart';

@Component(
    selector: 'user-bar',
    template: '''
      <google-signin 
      *ngIf="!isSignedIn"
      clientId="499749973436-s5enn1mvt99c8vbjdlcm390l3a5ugna0.apps.googleusercontent.com" width="240"
               theme="dark" longTitle="true" fetchBasicProfile="true"
               (googleSigninSuccess)="onGoogleSigninSuccess"></google-signin>
       <span
       *ngIf="isSignedIn"
       >
       Logged user: {{state?.loggedUser?.email}}
       </span>
       
       <button
       *ngIf="state.onNavigationStateChanged.value.showCreateGameButton"
       (click)="goToCreate()"
       >
         Create game
       </button>
       
      ''',
    directives: [GoogleSignin, coreDirectives],
    changeDetection: ChangeDetectionStrategy.OnPush)
class UserBarComponent {
  final http.Client _http;
  final StateService state;
  final GatewayService gatewayService;

  bool get isSignedIn => state.isUserSignedIn;
  final ChangeDetectorRef _cdRef;

  UserBarComponent(this._http, this.state, this.gatewayService, this._cdRef) {
    state.onNavigationStateChanged.listen((_) => _cdRef.markForCheck());
  }

  void onGoogleSigninSuccess(GoogleSignInSuccess event) async {
    GoogleUser googleUser = event.googleUser;
    AuthResponse response = googleUser.getAuthResponse();
    http.Response loginResponse = await _http.post("/userApi/login",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"id": response.id_token}));
    state.loggedUser =
        model.User.fromGoogleJson(json.decode(loginResponse.body));
    state.isUserSignedIn = true;
  }

  void signOut() {
    getAuthInstance().signOut();
    state.isUserSignedIn = false;
  }

  void goToCreate() {
    state.goToState(GameNavigationState.createGame);
  }
}
