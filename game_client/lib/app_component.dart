import 'package:angular/angular.dart';
import 'package:game_client/src/create_game/create_game_component.dart';
import 'package:game_client/src/game/game.dart';
import 'package:game_client/src/lobby/lobbies.dart';
import 'package:game_client/src/lobby/lobby.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/game_service.dart';
import 'package:game_client/src/user_bar/user_bar.component.dart';
import 'package:shared/model/model.dart';
import 'package:angular/core.dart';
import 'dart:html';

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
  AppService appService;
  GameService gameService;
  final ChangeDetectorRef changeDetector;

  bool get showCreateGame =>
      appService.navigationState.value.name == GameNavigationState.createGame;

  bool get showLobby =>
      appService.navigationState.value.name == GameNavigationState.inLobby;

  bool get showLobbies =>
      appService.navigationState.value.name == GameNavigationState.findLobby;

  bool get showGame =>
      appService.navigationState.value.name == GameNavigationState.inGame;

  // unused services are used for gateway handler injection
  AppComponent(
      this.appService,
      this.changeDetector,
      this.gameService,
      ) {
    appService.navigationState.listen((_) => changeDetector.markForCheck());

    window.onResize.listen(resizeBody);
  }

  void resizeBody([_]){
    document.body.style.width = "${window.innerWidth}px";
    document.body.style.height = "${window.innerHeight}px";
  }
}
