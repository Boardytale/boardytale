import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:core/model/model.dart' as core;

import 'lobby_players/lobby_players.dart';

@Component(selector: 'lobbies', directives: [NgFor, NgIf, LobbyPlayersComponent], template: '''
      <div class="container-fluid">
        <h1>Lobbies</h1>
        <div
          *ngFor="let lobby of lobbyService.lobbies.value"
          class="lobbyTile row"
        >
          <div class="col-1">
            <img [src]="lobby.image.data" />
          </div>
          <div class="col-2">
             <lobby-players
            [players]="lobby.players"
          ></lobby-players>
          </div>
          <div class="col-4">
            <h2>{{lobby.name[settingsService.language]}} - {{lobby.lobbyName}}</h2>
          </div>
          <div class="col-3">
            <p>{{lobby.description[settingsService.language]}}</p>
          </div>
          <div class="col-2">
            <button
              type="button"
              class="btn btn-primary mt-1"
              (click)="enterGame(lobby)"
            >Enter game</button>
          </div>
        </div>
        <div *ngIf="lobbyService.lobbies.value != null && lobbyService.lobbies.value.length == 0">
          No lobbies found
        </div>
      </div>
      ''')
class LobbiesComponent {
  LobbyService lobbyService;
  SettingsService settingsService;
  final ChangeDetectorRef changeDetector;
  GatewayService gateway;

  LobbiesComponent(this.lobbyService, this.settingsService, this.changeDetector, this.gateway) {
    lobbyService.lobbies.listen((onData) => changeDetector.markForCheck());
  }

  void enterGame(core.OpenedLobby lobby) {
    gateway.sendMessage(core.ToGameServerMessage.enterLobby(lobby.id));
  }
}
