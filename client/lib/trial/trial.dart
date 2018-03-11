import 'dart:async';
import 'package:angular/core.dart';
import 'package:boardytale_client/services/state_service.dart';
import 'package:boardytale_client/world/model/model.dart';
import 'package:boardytale_client/world/world_component.dart';

@Component(
    selector: 'trial',
    template: '''
      <h1 style="position: absolute">trial</h1>
     <world></world>
      ''',
    directives: const [WorldComponent],
    styles: const [":host{display: block;}"])
class TrialComponent {
  StateService state;
  TrialComponent(this.state) {
    this.state.onTaleLoaded.add(taleLoaded);
    this.state.loadTale("0");
  }

  void taleLoaded() {
    // DO initialization of players
  }
}
