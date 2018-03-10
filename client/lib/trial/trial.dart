import 'dart:async';
import 'package:angular/core.dart';
import 'package:boardytale_client/services/settings_service.dart';
import 'package:boardytale_client/services/tale_service.dart';
import 'package:boardytale_client/services/world_service.dart';
import 'package:boardytale_client/world/view/world_view.dart';
import 'package:boardytale_client/world/world_component.dart';

@Component(
    selector: 'trial',
    template: '''
      <h1 style="position: absolute">trial</h1>
     <world></world>
      ''',
    directives: const[WorldComponent])
class TrialComponent {
  TaleService taleService;
  TrialComponent(this.taleService){
    this.taleService.onTaleLoaded.add(taleLoaded);
    new Future.delayed(const Duration(seconds: 1)).then((_){
      this.taleService.load("0");
    });
  }

  void taleLoaded(){
    // DO initialization of players
  }
}
