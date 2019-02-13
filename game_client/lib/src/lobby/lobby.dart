import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/components/player_list.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/services/state_service.dart';
import 'package:game_client/src/world/world_component.dart';

part 'arrow_disk.dart';

@Component(
    selector: 'lobby',
    directives: [WorldComponent,PlayerListComponent, ArrowDisk, NgFor],
    template: '''
      <h1>lobby {{lobbyService.openedLobby.value?.name}}</h1>
      <player-list></player-list>
      ''',
    styles: [
      """
        :host{
          color: white;
        }
      """
    ])
class LobbyComponent {
  final ChangeDetectorRef changeDetector;

  LobbyService lobbyService;

  LobbyComponent(this.lobbyService, this.changeDetector){
    lobbyService.openedLobby.listen((onData) => changeDetector.markForCheck());
  }
}
