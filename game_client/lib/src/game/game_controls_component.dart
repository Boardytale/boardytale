import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/services/game_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:shared/model/model.dart' as shared;

@Component(
    selector: 'game-controls',
    directives: [coreDirectives, formDirectives],
    template: """
      <div class='game-controls-cont'>
        <button (click)='endTurn()'>End turn</button>
        <button (click)='switchShowCoordinates()'>{{gameService.showCoordinateLabels.value?"Hide coordinate labels": "Show coordinate labels"}}</button>
        <span>Players on move: {{getPlayersOnMoveLabel()}}</span>
      </div>
    """,
    changeDetection: ChangeDetectionStrategy.OnPush)
class GameControlsComponent {
  GameService gameService;
  GatewayService gateway;
  final ChangeDetectorRef changeDetector;
  GameControlsComponent(this.gameService, this.gateway, this.changeDetector){
    this.gameService.showCoordinateLabels.listen((_)=>changeDetector.markForCheck());
    this.gameService.playersOnMove.listen((_)=>changeDetector.markForCheck());
    this.gameService.aiGroupOnMove.listen((_)=>changeDetector.markForCheck());
  }

  void endTurn(){
    gateway.sendMessage(shared.ToGameServerMessage.controlsAction(shared.ControlsActionName.andOfTurn));
  }

  void switchShowCoordinates(){
    gameService.showCoordinateLabels.add(!gameService.showCoordinateLabels.value);
  }

  String getPlayersOnMoveLabel(){
    if(gameService.playersOnMove.value != null){
      return gameService.playersOnMove.value.map((ClientPlayer player){
        return player.name;
      }).join(", ");
    }
    if(gameService.aiGroupOnMove.value != null){
      return "${gameService.aiGroupOnMove.value.id} TODO: some loading wheel or something like that";
    }
    return "";
  }
}
