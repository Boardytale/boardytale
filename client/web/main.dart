import 'package:boardytale_client/app_component.dart';
import 'package:angular/angular.dart';
import 'package:boardytale_client/services/settings_service.dart';
import 'package:boardytale_client/services/tale_service.dart';
import 'package:boardytale_client/services/world_service.dart';

void main() {
  var taleService = new TaleService();
  Map settingsData = <String, dynamic>{};
  SettingsService settings = new SettingsService()..fromMap(settingsData);
  bootstrap(AppComponent, [
    provide(TaleService, useValue: taleService),
    provide(WorldService, useValue: new WorldService(taleService, settings)),
    provide(SettingsService, useValue: settings)
  ]);
}
