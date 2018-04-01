import 'package:angular/core.dart';
import 'package:angular/di.dart';
import 'package:angular/src/common/directives.dart';
import 'package:boardytale_client/src/services/gateway_service.dart';
import 'package:boardytale_client/src/services/state_service.dart';
import 'package:boardytale_client/src/world/model/model.dart';
import 'package:boardytale_commons/model/model.dart' as commonLib;

@Component(
    selector: "player-list",
    directives: const [NgFor],
    template: """
    <div class="players">
      <div *ngFor="let player of players" [class.is-me]="player==me" [class.is-done]='player.isDone' style="color:{{player.color}}">
        {{player.name}} - {{player.connectionName}}
      </div>
    </div>
""",
    styles: const [
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
  final StateService state;
  final GatewayService gateway;
  final ChangeDetectorRef changeDetector;
  Player me;

  PlayerListComponent(this.changeDetector, this.state, this.gateway) {
    gateway.onMessage.add(updateOnMessage);
  }
  void updateOnMessage(Map<String, dynamic> message) {
    String type = message["type"];
    if (type == "tale" || type == "connection" || type == "state") {
      me = gateway.me;
      changeDetector.detectChanges();
    }
  }

  List<Player> get players {
    if (state.tale == null) return const [];
    List<Player> players = [];
    for (commonLib.Player player in state.tale.players.values) {
      players.add(player);
    }
    return players;
  }
}
