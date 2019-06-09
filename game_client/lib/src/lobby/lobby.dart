import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:game_client/src/lobby/lobby_players/lobby_players.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/hero_service.dart';
import 'package:game_client/src/services/lobby_service.dart';
import 'package:game_client/src/game/world_component.dart';
import 'package:core/model/model.dart' as core;

@Component(selector: 'lobby', directives: [WorldComponent, LobbyPlayersComponent, coreDirectives], templateUrl: "lobby.html")
class LobbyComponent {
  final ChangeDetectorRef changeDetector;
  GatewayService gateway;

  core.OpenedLobby get lobby => lobbyService.openedLobby.value;
  LobbyService lobbyService;
  List<core.GameHeroCreateEnvelope> myHeroes;
  final AppService appService;
  final HeroService heroService;

  LobbyComponent(this.lobbyService, this.changeDetector, this.gateway, this.appService, this.heroService) {
    lobbyService.openedLobby.listen((onData) {
      changeDetector.markForCheck();
      //      if(onData.id != null){
      //        gateway.sendMessage(core.ToGameServerMessage.enterGame(onData.id));
      //      }
    });

    refreshMyHeroes();
  }

  void enterGame() {
    gateway.sendMessage(core.ToGameServerMessage.enterGame(lobby.id));
  }

  void refreshMyHeroes() async {
    myHeroes = await heroService.getMyHeroes();
    changeDetector.markForCheck();
  }

  void selectHero(core.GameHeroCreateEnvelope hero) {}
}
