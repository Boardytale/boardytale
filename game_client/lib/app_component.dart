import 'package:angular/angular.dart';
import 'package:game_client/src/create_game/create_game_component.dart';
import 'package:game_client/src/game/game.dart';
import 'package:game_client/src/lobby/lobbies.dart';
import 'package:game_client/src/lobby/lobby.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/user_bar/user_bar.component.dart';
import 'package:shared/model/model.dart';
import 'package:angular/core.dart';

@Component(
    selector: 'my-app',
    template: '''
  <div class="main-wrapper">
    <user-bar class="navbar navbar-expand-lg navbar-light bg-light"></user-bar>
    <create-game
      *ngIf="showCreateGame"
    ></create-game>
    <lobby
     *ngIf="showLobby"
    ></lobby>
    <lobbies
      *ngIf="showLobbies"
    >
    </lobbies>
    <game
    *ngIf="showGame"
    >
    </game>
  </div>
  
  ''',
    directives: [
      UserBarComponent,
      CreateGameComponent,
      coreDirectives,
      LobbyComponent,
      LobbiesComponent,
      GameComponent,
    ],
    changeDetection: ChangeDetectionStrategy.OnPush)
class AppComponent {
  AppService state;
  final ChangeDetectorRef changeDetector;

  bool get showCreateGame =>
      state.navigationState.value.name == GameNavigationState.createGame;

  bool get showLobby =>
      state.navigationState.value.name == GameNavigationState.inLobby;

  bool get showLobbies =>
      state.navigationState.value.name == GameNavigationState.findLobby;

  bool get showGame =>
      state.navigationState.value.name == GameNavigationState.inGame;

  AppComponent(this.state, this.changeDetector) {
    state.navigationState.listen((_) => changeDetector.markForCheck());
  }
}
