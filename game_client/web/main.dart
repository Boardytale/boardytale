import 'package:angular/angular.dart';
import 'package:game_client/app_component.template.dart' as ng;
import 'package:game_client/src/services/create_game_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:game_client/src/services/state_service.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'main.template.dart' as self;

@GenerateInjector([
  ClassProvider(Client, useClass: BrowserClient),
  ClassProvider(StateService),
  ClassProvider(SettingsService),
  ClassProvider(GatewayService),
  ClassProvider(LobbyService),
  ClassProvider(CreateGameService),
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
