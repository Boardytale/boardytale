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

  GoToState get goToState => GoToState.fromJson(json.decode(content));

  factory ToGameServerMessage.createGoToState(GameNavigationState newState) {
    return ToGameServerMessage()
      ..message = OnServerAction.goToState
      ..content = json.encode((GoToState()..newState = newState).toJson());
  }

  // ---

  String get initInnerToken => content;

  factory ToGameServerMessage.createInit(String innerToken) {
    return ToGameServerMessage()
      ..content = innerToken
      ..message = OnServerAction.init;
  }

  // ---

  CreateLobby get getCreateLobby => CreateLobby.fromJson(json.decode(content));

  factory ToGameServerMessage.createCreateLobby(String taleName, String roomName) {
    return ToGameServerMessage()
      ..content = jsonEncode((CreateLobby()
            ..taleName = taleName
            ..name = roomName)
          .toJson())
      ..message = OnServerAction.createLobby;
  }

  // ---

  String get enterLobbyOfId => content;

  factory ToGameServerMessage.createEnterLobby(String lobbyId) {
    return ToGameServerMessage()
      ..content = lobbyId
      ..message = OnServerAction.enterLobby;
  }

  // ---

  String get enterGameLobbyId => content;

  factory ToGameServerMessage.createEnterGame(String lobbyId) {
    return ToGameServerMessage()
      ..content = lobbyId
      ..message = OnServerAction.enterGame;
  }

  // ---

  UnitTrackAction get unitTrackAction => UnitTrackAction.fromJson(json.decode(content));

  factory ToGameServerMessage.createUnitTrackAction(UnitTrackAction action) {
    return ToGameServerMessage()
      ..content = jsonEncode(action.toJson())
      ..message = OnServerAction.unitTrackAction;
  }

  // ---

  PlayerIntention get playerIntention => PlayerIntention.fromJson(json.decode(content));

  factory ToGameServerMessage.createPlayerIntention(List<String> fieldsId) {
    return ToGameServerMessage()
      ..content = jsonEncode((PlayerIntention()..fieldsId = fieldsId).toJson())
      ..message = OnServerAction.playerGameIntention;
  }

  // ---

  ControlsAction get controlsAction => ControlsAction.fromJson(json.decode(content));

  factory ToGameServerMessage.createControlsAction(ControlsActionName actionName) {
    return ToGameServerMessage()
      ..content = jsonEncode((ControlsAction()..actionName = actionName).toJson())
      ..message = OnServerAction.controlsAction;
  }
  // ---

  factory ToGameServerMessage.leaveGame() {
    return ToGameServerMessage()
      ..content = ""
      ..message = OnServerAction.leaveGame;
  }
  // ---

  String get setHeroForNextGameHeroId => content;

  factory ToGameServerMessage.createSetHeroForNextGame(String heroId) {
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
class PlayerIntention extends MessageContent {
  List<String> fieldsId;

  static PlayerIntention fromJson(Map<String, dynamic> json) => _$PlayerIntentionFromJson(json);

  Map<String, dynamic> toJson() {
    return _$PlayerIntentionToJson(this);
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
