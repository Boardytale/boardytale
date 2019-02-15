import 'package:angular/core.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/game/world_component.dart';

@Component(selector: 'trial', template: '''
      <h1 style="position: absolute">trial</h1>
     <world></world>
      ''', directives: [WorldComponent], styles: [":host{display: block;}"])
class TrialComponent {
  final AppService state;
  TrialComponent(this.state) {
//    this.state.onTaleLoaded.add(taleLoaded);
//    this.state.loadTale("0");
  }

  void taleLoaded() {
    // DO initialization of players
  }
}
