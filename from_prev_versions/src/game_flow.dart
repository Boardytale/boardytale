part of deskovka_client;

class GameFlow {
  String phase;
  MatchMaking matchmaking;
  DivElement header;
  WebSocket socket;
  Login login;
  UnitSelection selection;
  Game game;

  GameFlow();

  bool get OnMove=> game.playerOnMove==game.you;

  init(){
    game = new Game();
    game.init();
    matchmaking = new MatchMaking();
    openSocket();
  }


  void send(String action, Map data){
    socket.send(JSON.encode({"action": action, "data": data}));
  }

  void openSocket(){
    String address = 'ws://${window.location.host}$CONTROLLER_WEBSOCKET';
//    window.console.log('ws://${window.location.host}/$CONTROLLER_WEBSOCKET');
    socket = new WebSocket(address);
    socket.onOpen.listen((_){
      send(CONTROLLER_STATE, {});
    });
    socket.onMessage.listen((MessageEvent message){
      Map json = JSON.decode(message.data.toString());
      Map data = json["data"];
      String state = json["state"];
      if(json.containsKey("action") && json["action"] != null){
        String action = json["action"];
        switch(action){
          case ACTION_CHANGE_STATE:
            changeState(data, state);
            return;
          case ACTION_GAMES:
            if(matchmaking != null){
              matchmaking.games = data["games"];
            }
            return;
          case ACTION_JOINED_GAME:
            if(matchmaking!=null)matchmaking.destroy();
            game.fromJson(data);
            selection = new UnitSelection(this);
            return;
          case MESSAGE_GAME_IS_FULL:
            window.alert(lang["messages"]["gameIsFull"]);
            return;
          case ACTION_START_GAME:
            if(selection!=null){
              selection.destroy();
              selection = null;
            }
            game.fromJson(data);
            game.start();
            return;
          case ACTION_TRACK_CHANGE:
            if(data==null){
              game.world.clearTrack();
            }else{
              Track track = new Track(null)..fromJson(data, game.world);
              game.world.paintTrack(track, "#FF0400");
            }
            return;
          case ACTION_NEXT_TURN:
            game.newTurn(data);
            return;
          case ACTION_PLAYERS_CHANGE:
            matchmaking.players=data["players"];
        }
      }
    });
  }


  void changeState(Map data, String state){
    if(data.containsKey("games")){
      matchmaking.games = data["games"];
    }
    if(data.containsKey("game")){
      game.fromJson(data["game"]);
    }
    if(data.containsKey("players")){
      matchmaking.players = data["players"];
    }
    if(data.containsKey("player")){
      game.you.fromJson(data["player"]);
    }
    if(game.you != null && game.you.nick != null){
      if(header == null){
        header = new DivElement();
        header.classes.add("header");
        document.body.append(header);
      }
      header.text = "logged ${game.you.nick}: ${game.you.id}";
    }

    if(login != null){
      login.destroy();
      login = null;
    }

    if(matchmaking != null){
      matchmaking.close();
    }

    if(state == STATE_NOT_LOGGED)login = new Login(this);
    if(state == STATE_MATCHMAKING)matchmaking.open();
    if(state == STATE_STATS)stats(data["stats"]);
    if(state == STATE_UNITS)selection = new UnitSelection(this);
    if(state == STATE_GAME)game.start();
  }

  void stats(Map data){
  }
}
