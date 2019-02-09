import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/services/create_game_service.dart';


@Component(
    selector: 'create-game',
    directives: [NgFor],
    template: '''
      <h1>Create game</h1>
      <div
        *ngFor="let game of createGameService.onStateChanged.value"
      >
        {{game.name}}
      </div>
      ''',
    changeDetection: ChangeDetectionStrategy.OnPush)

class CreateGameComponent {

  CreateGameService createGameService;

  CreateGameComponent(this.createGameService){

  }
}
