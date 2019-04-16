import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:core/model/model.dart' as core;

@Component(selector: 'lobby-players', directives: [coreDirectives], templateUrl: "lobby_players.html")
class LobbyPlayersComponent {
  final ChangeDetectorRef changeDetector;

  @Input()
  List<core.Player> players = [];

  LobbyPlayersComponent(this.changeDetector) {}
}
