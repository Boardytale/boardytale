import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:game_client/src/services/game_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:shared/model/model.dart' as shared;

@Component(
    selector: 'game-controls',
    directives: [coreDirectives, formDirectives],
    template: """
      <div>
        <button (click)='endTurn()'>End turn</button>
      </div>
    """,
    changeDetection: ChangeDetectionStrategy.OnPush)
class GameControlsComponent {
  GameService gameService;
  GatewayService gateway;
  GameControlsComponent(this.gameService, this.gateway){

  }

  void endTurn(){
    gateway.sendMessage(shared.ToGameServerMessage.controlsAction(shared.ControlsActionName.andOfTurn));
  }


}
