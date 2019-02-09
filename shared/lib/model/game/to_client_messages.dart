part of model;

@JsonSerializable()
class ToClientMessage {
  OnClientAction message;
  String content;

  ToClientMessage();

  // ---

  RefreshLobbyList get refreshLobbyListMessage =>
      RefreshLobbyList.fromJson(json.decode(content));

  factory ToClientMessage.fromRefreshLobbyList(List<LobbyTale> lobbyList) {
    return ToClientMessage()
      ..message = OnClientAction.refreshLobbyList
      ..content =
          json.encode((RefreshLobbyList()..lobbies = lobbyList).toJson());
  }

  // ---

  SetNavigationState get navigationStateMessage =>
      SetNavigationState.fromJson(json.decode(content));

  factory ToClientMessage.fromSetNavigationState(GameNavigationState newState) {
    return ToClientMessage()
      ..message = OnClientAction.setNavigationState
      ..content =
          json.encode((SetNavigationState()..newState = newState).toJson());
  }

  // ---

  GetGamesToCreate get getGamesToCreateMessage =>
      GetGamesToCreate.fromJson(json.decode(content));

  factory ToClientMessage.fromGamesToCreateMessage(List<LobbyTale> lobbyList) {
    return ToClientMessage()
      ..message = OnClientAction.getGamesToCreate
      ..content =
          json.encode((GetGamesToCreate()..games = lobbyList).toJson());
  }

  // ---

  SetCurrentUser get getCurrentUser =>
      SetCurrentUser.fromJson(json.decode(content));

  factory ToClientMessage.fromCurrentUser(User user) {
    return ToClientMessage()
      ..message = OnClientAction.setCurrentUser
      ..content =
      json.encode((SetCurrentUser()..user = user).toJson());
  }

  static ToClientMessage fromJson(Map<String, dynamic> json) =>
      _$ToClientMessageFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ToClientMessageToJson(this);
  }
}

@Typescript()
enum OnClientAction {
  @JsonValue('setNavigationState')
  setNavigationState,
  @JsonValue('refreshLobbyList')
  refreshLobbyList,
  @JsonValue('getGamesToCreate')
  getGamesToCreate,
  @JsonValue('setCurrentUser')
  setCurrentUser,
}

abstract class MessageContent {}

@JsonSerializable()
class SetNavigationState extends MessageContent {
  GameNavigationState newState;

  static SetNavigationState fromJson(Map<String, dynamic> json) =>
      _$SetNavigationStateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$SetNavigationStateToJson(this);
  }
}

@JsonSerializable()
class RefreshLobbyList extends MessageContent {
  List<LobbyTale> lobbies;

  static RefreshLobbyList fromJson(Map<String, dynamic> json) =>
      _$RefreshLobbyListFromJson(json);

  Map<String, dynamic> toJson() {
    return _$RefreshLobbyListToJson(this);
  }
}

@JsonSerializable()
class GetGamesToCreate extends MessageContent {
  List<LobbyTale> games;

  static GetGamesToCreate fromJson(Map<String, dynamic> json) =>
      _$GetGamesToCreateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GetGamesToCreateToJson(this);
  }
}

@JsonSerializable()
class SetCurrentUser extends MessageContent {
  User user;

  static SetCurrentUser fromJson(Map<String, dynamic> json) =>
      _$SetCurrentUserFromJson(json);

  Map<String, dynamic> toJson() {
    return _$SetCurrentUserToJson(this);
  }
}
