import 'package:boardytale_client/src/app_component.dart';
import 'package:angular/angular.dart';
import 'package:boardytale_client/src/services/gateway_service.dart';
import 'package:boardytale_client/src/services/settings_service.dart';
import 'package:boardytale_client/src/services/state_service.dart';

void main() {
  Map settingsData = <String, dynamic>{};
  SettingsService settings = new SettingsService()..fromMap(settingsData);
  var stateService = new StateService(settings);
  bootstrap(AppComponent, <dynamic>[
    provide(StateService, useValue: stateService),
    provide(SettingsService, useValue: settings),
    provide(GatewayService, useValue: new GatewayService(stateService))
  ]);
}
