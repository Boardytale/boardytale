import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:shared/model/model.dart' as shared;

@Component(selector: 'lobbies', directives: [NgFor], template: '''
      <h1>Lobbies</h1>
      <div
        *ngFor="let lobby of lobbyService.lobbies.value"
      >
        <h2>{{lobby.name[settingsService.language]}} - {{lobby.lobbyName}}</h2>
        <p>{{lobby.description[settingsService.language]}}</p>
        <img [src]="lobby.image.data" />
        <button
          (click)="enterGame(lobby)"
        >Enter game</button>
      </div>
      ''')
class LobbiesComponent {
  LobbyService lobbyService;
  SettingsService settingsService;
  final ChangeDetectorRef changeDetector;
  GatewayService gateway;

  LobbiesComponent(this.lobbyService, this.settingsService, this.changeDetector,
      this.gateway) {
    lobbyService.lobbies.listen((onData) => changeDetector.markForCheck());
  }

  void enterGame(shared.OpenedLobby lobby) {
    gateway.sendMessage(shared.ToGameServerMessage.enterLobby(lobby.id));
  }
}
