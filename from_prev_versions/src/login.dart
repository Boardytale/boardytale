part of deskovka_client;

class Login {
  GameFlow gameFlow;
  OverlayDiv div;
  StreamSubscription keydown;
  ClientPlayer player;
  Login(this.gameFlow) {
    div = new OverlayDiv("loginScreen");
    div.style.backgroundColor = "blue";

    div.div.innerHtml = """

      <h1>Login</h1>
      <span>Nick: <input type="text" id="nick" value="player${new Math.Random().nextInt(600)}"></span>
      <button>Send</button>

    """;

    div.div.querySelector("button").onClick.listen(sendLogin);

    keydown = window.onKeyDown.listen((KeyboardEvent e) {
      if (e.keyCode == KeyCode.ENTER) {
        sendLogin(null);
      }
    });
  }

  void sendLogin(_) {
    gameFlow.send(ACTION_LOGIN,
        {"nick": (div.div.querySelector("#nick") as InputElement).value});
    keydown.cancel();
  }

  void destroy() {
    div.destroy();
  }
}
