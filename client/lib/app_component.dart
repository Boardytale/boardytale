import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_router/angular_router.dart';

import 'editor/editor.dart';
import 'lobby/lobby.dart';
import 'game/game.dart';
import 'trial/trial.dart';

@Component(
    selector: 'boardytale',
    template: '''
      <nav style="z-index: 1">
        <a [routerLink]="['Lobby']">Lobby</a>
        <a [routerLink]="['Game']">Game</a>
        <a [routerLink]="['Editor']">Tale editor</a>
        <a [routerLink]="['Trial']">Try it</a>
      </nav>
      <router-outlet></router-outlet>''',
    directives: const [ROUTER_DIRECTIVES],
    providers: const <dynamic>[
      ROUTER_PROVIDERS,
    ],
    host: const{
      "style":"position:relative"
    },
    styles: const[":host{display: block;}"],
    changeDetection: ChangeDetectionStrategy.OnPush)
@RouteConfig(const [
  const Route(
      path: '/lobby',
      name: 'Lobby',
      component: LobbyComponent,
      useAsDefault: true),
  const Route(path: '/game', name: 'Game', component: GameComponent),
  const Route(path: '/editor', name: 'Editor', component: EditorComponent),
  const Route(path: '/trial', name: 'Trial', component: TrialComponent)
])
class AppComponent {
  String title = 'Tour of Heroes';

  AppComponent() {

  }
}
