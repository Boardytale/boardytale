import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/lobby/lobby_players/lobby_players.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/game/world_component.dart';
import 'package:core/model/model.dart' as core;

part 'arrow_disk.dart';

@Component(
    selector: 'lobby', directives: [WorldComponent, LobbyPlayersComponent, ArrowDisk, coreDirectives], template: '''
      <div 
      *ngIf="lobby != null"
      class="lobby-room"> 
        <h1>lobby {{lobby.lobbyName}}</h1>
        <img [src]="lobby.image.data">
        <lobby-players
          [players]="lobby.players"
        ></lobby-players>
        <button (click)="enterGame()">Start game</button>
      </div>
      ''')
class LobbyComponent {
  final ChangeDetectorRef changeDetector;
  GatewayService gateway;

  core.OpenedLobby get lobby => lobbyService.openedLobby.value;
  LobbyService lobbyService;

  LobbyComponent(this.lobbyService, this.changeDetector, this.gateway) {
    lobbyService.openedLobby.listen((onData) {
      changeDetector.markForCheck();
//      if(onData.id != null){
//        gateway.sendMessage(core.ToGameServerMessage.enterGame(onData.id));
//      }
    });
  }

  void enterGame() {
    gateway.sendMessage(core.ToGameServerMessage.enterGame(lobby.id));
  }
}
