import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/services/app_service.dart';
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
        <span *ngIf='gameService.playersOnMove.value != null'>Players on move:
          <span *ngFor='let player of gameService.playersOnMove.value' [ngStyle]="{'color': player.color}">
            {{player.name}}
          </span>
        </span>
      </div>
    """,
    changeDetection: ChangeDetectionStrategy.OnPush)
class GameControlsComponent {
  GameService gameService;
  AppService appService;
  GatewayService gateway;
  final ChangeDetectorRef changeDetector;
  GameControlsComponent(this.gameService, this.gateway, this.changeDetector, this.appService){
    this.gameService.showCoordinateLabels.listen((_)=>changeDetector.markForCheck());
    this.gameService.playersOnMove.listen((_)=>changeDetector.markForCheck());
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
        return player.humanPlayer != null? player.humanPlayer.name : player.aiGroup.langName[appService.language];
      }).join(", ");
    }
    return "";
  }
}
