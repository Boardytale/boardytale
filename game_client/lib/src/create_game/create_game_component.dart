import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:game_client/src/services/create_game_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:core/model/model.dart' as core;

@Component(
    selector: 'create-game',
    directives: [coreDirectives, formDirectives],
    templateUrl: "create_game_component.html",
    changeDetection: ChangeDetectionStrategy.OnPush)
class CreateGameComponent {
  final ChangeDetectorRef changeDetector;
  CreateGameService createGameService;
  SettingsService settingsService;
  GatewayService gateway;
  String selectedTaleId;
  String roomName = "Untitled lobby";

  core.LobbyTale get selectedTale {
    for (var tale in createGameService.talesToCreate.value) {
      if (tale.id == selectedTaleId) {
        return tale;
      }
    }
    return null;
  }

  CreateGameComponent(
    this.createGameService,
    this.changeDetector,
    this.settingsService,
    this.gateway,
  ) {
    createGameService.talesToCreate.listen((data) {
      selectedTaleId = data.first.id;
      changeDetector.markForCheck();
//      createLobby();
    });
  }

  void createLobby() {
    gateway.toGameServerMessage(core.ToGameServerMessage.createCreateLobby(selectedTaleId, roomName));
  }

  void selectLobby(String id) {
    selectedTaleId = id;
  }
}
