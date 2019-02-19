import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:shared/model/model.dart' as shared;

@Component(
    selector: 'lobby-players',
    directives: [coreDirectives],
    templateUrl: "lobby_players.html")
class LobbyPlayersComponent {
  final ChangeDetectorRef changeDetector;

  @Input()
  List<shared.Player> players = [];

  LobbyPlayersComponent(this.changeDetector) {}
}
