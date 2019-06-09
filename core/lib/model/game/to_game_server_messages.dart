part of model;

@JsonSerializable()
class ToGameServerMessage {
  OnServerAction message;
  String content;

  ToGameServerMessage();

  Map<String, dynamic> toJson() {
    return _$ToGameServerMessageToJson(this);
  }

  static ToGameServerMessage fromJson(Map<String, dynamic> json) => _$ToGameServerMessageFromJson(json);

  // ---

  GoToState get goToStateMessage => GoToState.fromJson(json.decode(content));

  factory ToGameServerMessage.fromGoToState(GameNavigationState newState) {
    return ToGameServerMessage()
      ..message = OnServerAction.goToState
      ..content = json.encode((GoToState()..newState = newState).toJson());
  }

  // ---

  String get initMessageInnerToken => content;

  factory ToGameServerMessage.init(String innerToken) {
    return ToGameServerMessage()
      ..content = innerToken
      ..message = OnServerAction.init;
  }

  // ---

  CreateLobby get createLobbyMessage => CreateLobby.fromJson(json.decode(content));

  factory ToGameServerMessage.createLobby(String taleName, String roomName) {
    return ToGameServerMessage()
      ..content = jsonEncode((CreateLobby()
            ..taleName = taleName
            ..name = roomName)
          .toJson())
      ..message = OnServerAction.createLobby;
  }

  // ---

  String get enterLobbyOfId => content;

  factory ToGameServerMessage.enterLobby(String lobbyId) {
    return ToGameServerMessage()
      ..content = lobbyId
      ..message = OnServerAction.enterLobby;
  }

  // ---

  String get enterGameLobbyId => content;

  factory ToGameServerMessage.enterGame(String lobbyId) {
    return ToGameServerMessage()
      ..content = lobbyId
      ..message = OnServerAction.enterGame;
  }

  // ---

  UnitTrackAction get unitTrackActionMessage => UnitTrackAction.fromJson(json.decode(content));

  factory ToGameServerMessage.unitTrackAction(UnitTrackAction action) {
    return ToGameServerMessage()
      ..content = jsonEncode(action.toJson())
      ..message = OnServerAction.unitTrackAction;
  }

  // ---

  PlayerGameIntention get playerGameIntentionMessage => PlayerGameIntention.fromJson(json.decode(content));

  factory ToGameServerMessage.playerGameIntention(List<String> fieldsId) {
    return ToGameServerMessage()
      ..content = jsonEncode((PlayerGameIntention()..fieldsId = fieldsId).toJson())
      ..message = OnServerAction.playerGameIntention;
  }

  // ---

  ControlsAction get controlsActionMessage => ControlsAction.fromJson(json.decode(content));

  factory ToGameServerMessage.controlsAction(ControlsActionName actionName) {
    return ToGameServerMessage()
      ..content = jsonEncode((ControlsAction()..actionName = actionName).toJson())
      ..message = OnServerAction.controlsAction;
  }
  // ---

  factory ToGameServerMessage.leaveGameAction() {
    return ToGameServerMessage()
      ..content = ""
      ..message = OnServerAction.leaveGame;
  }
  // ---

  String get setHeroForNextGameHeroId => content;

  factory ToGameServerMessage.fromHeroForNextGameMessage(String heroId) {
    return ToGameServerMessage()
      ..content = heroId
      ..message = OnServerAction.setHeroForNextGame;
  }
// ---
}

@Typescript()
enum OnServerAction {
  @JsonValue('goToState')
  goToState,
  @JsonValue('init')
  init,
  @JsonValue('createLobby')
  createLobby,
  @JsonValue('enterLobby')
  enterLobby,
  @JsonValue('enterGame')
  enterGame,
  @JsonValue('leaveGame')
  leaveGame,
  @JsonValue('unitTrackAction')
  unitTrackAction,
  @JsonValue('playerGameIntention')
  playerGameIntention,
  @JsonValue('controlsAction')
  controlsAction,
  @JsonValue('setHeroForNextGame')
  setHeroForNextGame,
}

@JsonSerializable()
class GoToState extends MessageContent {
  GameNavigationState newState;

  static GoToState fromJson(Map<String, dynamic> json) => _$GoToStateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GoToStateToJson(this);
  }
}

@JsonSerializable()
class CreateLobby extends MessageContent {
  String taleName;
  String name;

  static CreateLobby fromJson(Map<String, dynamic> json) => _$CreateLobbyFromJson(json);

  Map<String, dynamic> toJson() {
    return _$CreateLobbyToJson(this);
  }
}

@JsonSerializable()
class UnitTrackAction extends MessageContent {
  AbilityName abilityName;
  String unitId;
  List<String> track;

  /// playerId_clientManagedActionId - originated by UserManipulateAction
  String actionId;

  static UnitTrackAction fromJson(Map<String, dynamic> json) => _$UnitTrackActionFromJson(json);

  Map<String, dynamic> toJson() {
    return _$UnitTrackActionToJson(this);
  }
}

@JsonSerializable()
class PlayerGameIntention extends MessageContent {
  List<String> fieldsId;

  static PlayerGameIntention fromJson(Map<String, dynamic> json) => _$PlayerGameIntentionFromJson(json);

  Map<String, dynamic> toJson() {
    return _$PlayerGameIntentionToJson(this);
  }
}

@JsonSerializable()
class ControlsAction extends MessageContent {
  ControlsActionName actionName;

  static ControlsAction fromJson(Map<String, dynamic> json) => _$ControlsActionFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ControlsActionToJson(this);
  }
}

@Typescript()
enum ControlsActionName {
  @JsonValue('endOfTurn')
  endOfTurn,
  @JsonValue('unitWillNotPlay')
  unitWillNotPlay,
}
