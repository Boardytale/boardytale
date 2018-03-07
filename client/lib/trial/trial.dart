import 'package:angular/core.dart';
import 'package:boardytale_client/services/settings_service.dart';
import 'package:boardytale_client/services/tale_service.dart';
import 'package:boardytale_client/services/world_service.dart';
import 'package:boardytale_client/world/view/world_view.dart';
import 'package:boardytale_client/world/world_component.dart';

@Component(
    selector: 'trial',
    template: '''
      <h1>trial</h1>
     <world></world>
      ''',
    directives: const[WorldComponent],
    providers: const[
      SettingsService,
      TaleService,
      WorldService
    ])
class TrialComponent {
  TaleService taleService;
  TrialComponent(this.taleService){
    this.taleService.onTaleLoaded.add(taleLoaded);
  }

  void taleLoaded(){
    // DO initialization of players
  }
}
