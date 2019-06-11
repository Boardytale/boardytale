import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:core/model/model.dart' as core;

import 'lobby_players/lobby_players.dart';

@Component(selector: 'lobbies', directives: [NgFor, NgIf, LobbyPlayersComponent], templateUrl: "lobbies.html")
class LobbiesComponent {
  LobbyService lobbyService;
  SettingsService settingsService;
  final ChangeDetectorRef changeDetector;
  GatewayService gateway;

  LobbiesComponent(this.lobbyService, this.settingsService, this.changeDetector, this.gateway) {
    lobbyService.lobbies.listen((onData) => changeDetector.markForCheck());
  }

  void enterGame(core.OpenedLobby lobby) {
    gateway.toGameServerMessage(core.ToGameServerMessage.createEnterLobby(lobby.id));
  }
}
