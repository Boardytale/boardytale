part of deskovka_client;

class MatchMaking {
  HttpRequest request;
  Race selected;
  Map data;
  final List onDestroy = [];
  final List onGamesChanged = [];
  final List onPlayersChanged = [];

  List _games;
  List get games => _games;

  List _players = [];
  List get players => _players;

  MatchMaking();

  void open() {
    new MatchmakingWidget(this);
  }

  set games(List value) {
    _games = value;
    callAll(onGamesChanged);
  }

  set players(List value) {
    _players = value;
    callAll(onPlayersChanged);
  }

  void close() {
    destroy();
  }

  void destroy() {
    callAll(onDestroy);
  }
}
