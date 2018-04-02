import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:boardytale_client/src/components/player_list.dart';
import 'package:boardytale_client/src/services/gateway_service.dart';
import 'package:boardytale_client/src/services/state_service.dart';
import 'package:boardytale_client/src/world/model/model.dart';
import 'package:boardytale_client/src/world/world_component.dart';
import 'package:utils/utils.dart';
import 'package:boardytale_commons/model/model.dart' as commonLib;

part 'arrow_disk.dart';

@Component(
    selector: 'lobby',
    directives: const [WorldComponent,PlayerListComponent, ArrowDisk, NgFor],
    template: '''
      <h1>lobby</h1>
      <player-list></player-list>
      <arrow-disk></arrow-disk>
      <world></world>
      ''',
    styles: const [
      """
        :host{
          color: white;
        }
      """
    ])
class LobbyComponent {
}
