import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/components/player_list.dart';
import 'package:game_client/src/services/create_game_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/services/state_service.dart';
import 'package:game_client/src/world/model/model.dart';
import 'package:game_client/src/world/world_component.dart';
import 'package:utils/utils.dart';
import 'package:shared/model/model.dart' as commonLib;


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
