import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:editor_client/src/create_image/create_image_component.dart';
import 'package:http/http.dart' as http;
import 'package:ng2_g_signin/ng2_g_signin.dart';

@Component(selector: 'my-app', template: '''
   <google-signin clientId="499749973436-s5enn1mvt99c8vbjdlcm390l3a5ugna0.apps.googleusercontent.com" width="240"
               theme="dark" longTitle="true" fetchBasicProfile="true"
               (googleSigninSuccess)="onGoogleSigninSuccess"></google-signin>
               
              <create-image></create-image>
  ''', directives: const [GoogleSignin, CreateImageComponent])
class AppComponent {
  final http.Client _http;

  AppComponent(this._http) {}
  bool isSignedIn = false;

  void onGoogleSigninSuccess(GoogleSignInSuccess event) async {
    GoogleUser googleUser = event.googleUser;
    AuthResponse response = googleUser.getAuthResponse();
    http.Response loginResponse = await _http.post("/userApi/login",
        headers: {"Content-Type": "application/json"}, body: json.encode({"id": response.id_token}));
    print(loginResponse.body);
  }

  void signOut() {
    getAuthInstance().signOut();
    isSignedIn = false;
  }
}
