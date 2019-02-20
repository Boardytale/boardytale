import 'package:angular/core.dart';
import 'package:angular/di.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/app_service.dart';

@Component(selector: "player-list", directives: [
  NgFor
], template: """
    <div class="players">
      <div 
      *ngFor="let player of players" 
      [class.is-me]="player==me" [class.is-done]='player.isDone' style="color:{{player.color}}">
        {{player.name}}
      </div>
    </div>
""", styles: [
  """
        .is-me{
          font-weight: bold;
        }
        .players{
          background-color: white;
          position:absolute;
          top:0;
          right:0;
        }
        .is-done{
          text-decoration: line-through;
        }
        """
])
class PlayerListComponent {
  final AppService state;
  final GatewayService gateway;
  final ChangeDetectorRef changeDetector;
  ClientPlayer me;

  PlayerListComponent(this.changeDetector, this.state, this.gateway) {
//    gateway.onMessage.listen(updateOnMessage);
  }
  void updateOnMessage(Map<String, dynamic> message) {
    String type = message["type"];
    if (type == "tale" || type == "connection" || type == "state") {
//      me = gateway.me;
      changeDetector.detectChanges();
    }
  }

  List<ClientPlayer> get players {
//    if (state.tale == null) return const [];
    List<ClientPlayer> players = [];
//    for (commonLib.LobbyPlayer player in state.tale.players.values) {
//      players.add(player);
//    }
    return players;
  }
}
