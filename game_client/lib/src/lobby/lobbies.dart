import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/services/settings_service.dart';

@Component(selector: 'lobby', directives: [NgFor], template: '''
      <h1>Lobbies</h1>
      <div
        *ngFor="let lobby of lobbyService.lobbies.value"
      >
        <h2>{{lobby.name[settingsService.language]}}</h2>
        <p>{{lobby.description}}</p>
        <img [src]="lobby.image.data" />
        <button>Enter game</button>
      </div>
      ''')
class LobbiesComponent {
  LobbyService lobbyService;
  SettingsService settingsService;
  final ChangeDetectorRef changeDetector;

  LobbiesComponent(
      this.lobbyService, this.settingsService, this.changeDetector) {
    lobbyService.lobbies.listen((onData) => changeDetector.markForCheck());
  }
}
