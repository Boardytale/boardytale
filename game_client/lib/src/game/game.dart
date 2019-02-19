import 'package:angular/core.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/game/world_component.dart';

@Component(selector: 'game', template: '''
      <h1>game</h1>
      <world></world>
      ''', directives: [WorldComponent], styles: [":host{display: block;}"])
class GameComponent {
  AppService state;
  GameComponent(this.state) {
//    this.state.onTaleLoaded.add(taleLoaded);
//    this.state.loadTale("arena");
  }

  void taleLoaded() {
    // DO initialization of players
  }
}
