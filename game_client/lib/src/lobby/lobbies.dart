import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/services/lobby_service.dart';

@Component(selector: 'lobby', directives: [NgFor], template: '''
      <h1>Lobbies</h1>
      <div
        *ngFor="let lobby of lobbyService.onLobbyStateChanged.value"
      >
        <h2>{{lobby.name}}</h2>
        <p>{{lobby.description}}</p>
        <img [src]="lobby.image.data" />
        <button>Enter game</button>
      </div>
      ''')
class LobbiesComponent {
  LobbyService lobbyService;

  LobbiesComponent(this.lobbyService) {}
}
