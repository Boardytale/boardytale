part of model;

@JsonSerializable()
class ToGameServerMessage {
  OnServerAction message;
  String content;

  ToGameServerMessage();

  Map<String, dynamic> toJson() {
    return _$ToGameServerMessageToJson(this);
  }

  static ToGameServerMessage fromJson(Map<String, dynamic> json) =>
      _$ToGameServerMessageFromJson(json);

  // ---

  GoToState get goToStateMessage => GoToState.fromJson(json.decode(content));

  factory ToGameServerMessage.fromGoToState(GameNavigationState newState) {
    return ToGameServerMessage()
      ..message = OnServerAction.goToState
      ..content = json.encode((GoToState()..newState = newState).toJson());
  }

  // ---

  InitMessage get initMessage => InitMessage.fromJson(json.decode(content));

  factory ToGameServerMessage.init(String innerToken) {
    return ToGameServerMessage()
      ..content = jsonEncode((InitMessage()..innerToken = innerToken).toJson())
      ..message = OnServerAction.init;
  }

  // ---

  CreateLobby get createLobbyMessage =>
      CreateLobby.fromJson(json.decode(content));

  factory ToGameServerMessage.createLobby(String taleName, String roomName) {
    return ToGameServerMessage()
      ..content = jsonEncode((CreateLobby()
            ..taleName = taleName
            ..name = roomName)
          .toJson())
      ..message = OnServerAction.createLobby;
  }
}

@Typescript()
enum OnServerAction {
  @JsonValue('goToState')
  goToState,
  @JsonValue('init')
  init,
  @JsonValue('createLobby')
  createLobby,
}

@JsonSerializable()
class GoToState extends MessageContent {
  GameNavigationState newState;

  static GoToState fromJson(Map<String, dynamic> json) =>
      _$GoToStateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GoToStateToJson(this);
  }
}

@JsonSerializable()
class InitMessage extends MessageContent {
  String innerToken;

  static InitMessage fromJson(Map<String, dynamic> json) =>
      _$InitMessageFromJson(json);

  Map<String, dynamic> toJson() {
    return _$InitMessageToJson(this);
  }
}

@JsonSerializable()
class CreateLobby extends MessageContent {
  String taleName;
  String name;

  static CreateLobby fromJson(Map<String, dynamic> json) =>
      _$CreateLobbyFromJson(json);

  Map<String, dynamic> toJson() {
    return _$CreateLobbyToJson(this);
  }
}
