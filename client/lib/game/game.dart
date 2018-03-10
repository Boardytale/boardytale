import 'dart:async';
import 'package:angular/core.dart';
import 'package:boardytale_client/services/settings_service.dart';
import 'package:boardytale_client/services/tale_service.dart';
import 'package:boardytale_client/services/world_service.dart';
import 'package:boardytale_client/world/view/world_view.dart';
import 'package:boardytale_client/world/world_component.dart';

@Component(
    selector: 'game',
    template: '''
      <h1>game</h1>
      <world></world>
      ''',
    directives: const[WorldComponent]
)
class GameComponent {
      TaleService taleService;
      GameComponent(this.taleService){
            this.taleService.onTaleLoaded.add(taleLoaded);
            new Future.delayed(const Duration(seconds: 1)).then((_){
              this.taleService.load("arena");
            });
      }

      void taleLoaded(){
            // DO initialization of players
      }
}
