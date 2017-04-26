import 'dart:html';
import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:boardytale_client/services/tale_service.dart';

@Component(
    selector: 'trial',
    template: '''
      <h1>trial</h1>
      ''',
    providers: const[TaleService])
class TrialComponent {
  TaleService taleService;
  TrialComponent(this.taleService){
    this.taleService.onTaleLoaded.add(taleLoaded);
  }

  void taleLoaded(){
    print(taleService.tale.toMap());
  }
}
