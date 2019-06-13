import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:ng2_g_signin/ng2_g_signin.dart';
import 'package:core/model/model.dart' as core;

@Component(
    selector: 'user-bar',
    templateUrl: 'user_bar.component.html',
    directives: [GoogleSignin, coreDirectives],
    changeDetection: ChangeDetectionStrategy.OnPush)
class UserBarComponent {
  final AppService appService;
  final GatewayService gatewayService;
  final ChangeDetectorRef _cdRef;

  UserBarComponent(this.appService, this.gatewayService, this._cdRef) {
    appService.navigationState.listen((_) => _cdRef.markForCheck());
    appService.currentUser.listen((_) => _cdRef.markForCheck());
  }

  void signOut() {
    getAuthInstance().signOut();
    appService.currentUser.add(null);
  }

  void goToCreate() {
    appService.goToState(core.GameNavigationState.createGame);
  }

  void goToUserPanel() {
    appService.goToState(core.GameNavigationState.userPanel);
  }

  String getUserLabel() {
    core.User user = appService.currentUser.value;
    if (user == null) {
      return "";
    }
    String out;
    if (user.name != null) {
      out = user.name;
    } else {
      out = user.email;
    }
    if (out.length > 20) {
      out = out.substring(0, 17) + "...";
    }
    return out;
  }

  void returnToAppState() {
    appService.goToState(core.GameNavigationState.findLobby);
  }

  bool showReturnToAppButton() {
    return appService.navigationState.value.name == core.GameNavigationState.userPanel &&
        appService.currentUser.value != null &&
        appService.currentUser.value.hasHero;
  }
}
