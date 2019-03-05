part of model;

@JsonSerializable()
class ToClientMessage {
  OnClientAction message;
  String content;

  ToClientMessage();

  static ToClientMessage fromJson(Map<String, dynamic> json) =>
      _$ToClientMessageFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ToClientMessageToJson(this);
  }

  // ---

  RefreshLobbyList get refreshLobbyListMessage =>
      RefreshLobbyList.fromJson(json.decode(content));

  factory ToClientMessage.fromLobbyList(List<OpenedLobby> lobbyList) {
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
      ..content = json.encode((GetGamesToCreate()..games = lobbyList).toJson());
  }

  // ---

  SetCurrentUser get getCurrentUser =>
      SetCurrentUser.fromJson(json.decode(content));

  factory ToClientMessage.fromCurrentUser(User user) {
    return ToClientMessage()
      ..message = OnClientAction.setCurrentUser
      ..content = json.encode((SetCurrentUser()..user = user).toJson());
  }

  // ---

  OpenedLobbyData get getOpenedLobbyData =>
      OpenedLobbyData.fromJson(json.decode(content));

  factory ToClientMessage.fromOpenedLobby(OpenedLobby lobby) {
    return ToClientMessage()
      ..message = OnClientAction.openedLobbyData
      ..content = json.encode((OpenedLobbyData()..lobby = lobby).toJson());
  }

  // ---

  TaleData get getTaleDataMessage => TaleData.fromJson(json.decode(content));

  factory ToClientMessage.fromTaleData(ClientTaleData data) {
    return ToClientMessage()
      ..message = OnClientAction.taleData
      ..content = json.encode((TaleData()..data = data).toJson());
  }

  // ---

  UnitCreateOrUpdate get getUnitCreateOrUpdate =>
      UnitCreateOrUpdate.fromJson(json.decode(content));

  factory ToClientMessage.fromUnitCreateOrUpdate(List<UnitCreateOrUpdateAction> actions) {
    return ToClientMessage()
      ..message = OnClientAction.unitCreateOrUpdate
      ..content = json.encode((UnitCreateOrUpdate()..actions = actions).toJson());
  }
  // ---

  UnitDelete get getUnitDelete =>
      UnitDelete.fromJson(json.decode(content));

  factory ToClientMessage.fromUnitDelete(List<UnitDeleteAction> actions) {
    return ToClientMessage()
      ..message = OnClientAction.unitDelete
      ..content = json.encode((UnitDelete()..actions = actions).toJson());
  }
  // ---

  CancelOnField get getCancelOnField =>
      CancelOnField.fromJson(json.decode(content));

  factory ToClientMessage.fromCancelOnField(List<CancelOnFieldAction> actions) {
    return ToClientMessage()
      ..message = OnClientAction.cancelOnField
      ..content = json.encode((CancelOnField()..actions = actions).toJson());
  }

  // ---

  IntentionUpdate get getIntentionUpdate =>
      IntentionUpdate.fromJson(json.decode(content));

  factory ToClientMessage.fromIntentionUpdate(
      String playerId, List<String> trackFieldsId) {
    return ToClientMessage()
      ..message = OnClientAction.intentionUpdate
      ..content = json.encode((IntentionUpdate()
            ..playerId = playerId
            ..trackFieldsId = trackFieldsId)
          .toJson());
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
  @JsonValue('openedLobbyData')
  openedLobbyData,
  @JsonValue('taleData')
  taleData,
  @JsonValue('unitCreateOrUpdate')
  unitCreateOrUpdate,
  @JsonValue('unitDelete')
  unitDelete,
  @JsonValue('cancelOnField')
  cancelOnField,
  @JsonValue('intentionUpdate')
  intentionUpdate,
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
  List<OpenedLobby> lobbies;

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

@JsonSerializable()
class OpenedLobbyData extends MessageContent {
  OpenedLobby lobby;

  static OpenedLobbyData fromJson(Map<String, dynamic> json) =>
      _$OpenedLobbyDataFromJson(json);

  Map<String, dynamic> toJson() {
    return _$OpenedLobbyDataToJson(this);
  }
}

@JsonSerializable()
class TaleData extends MessageContent {
  ClientTaleData data;

  static TaleData fromJson(Map<String, dynamic> json) =>
      _$TaleDataFromJson(json);

  Map<String, dynamic> toJson() {
    return _$TaleDataToJson(this);
  }
}

@JsonSerializable()
class UnitCreateOrUpdate extends MessageContent {
  List<UnitCreateOrUpdateAction> actions;

  static UnitCreateOrUpdate fromJson(Map<String, dynamic> json) =>
      _$UnitCreateOrUpdateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$UnitCreateOrUpdateToJson(this);
  }
}

@JsonSerializable()
class UnitDelete extends MessageContent {
  List<UnitDeleteAction> actions;

  static UnitDelete fromJson(Map<String, dynamic> json) =>
      _$UnitDeleteFromJson(json);

  Map<String, dynamic> toJson() {
    return _$UnitDeleteToJson(this);
  }
}

@JsonSerializable()
class CancelOnField extends MessageContent {
  List<CancelOnFieldAction> actions;

  static CancelOnField fromJson(Map<String, dynamic> json) =>
      _$CancelOnFieldFromJson(json);

  Map<String, dynamic> toJson() {
    return _$CancelOnFieldToJson(this);
  }
}

@JsonSerializable()
class IntentionUpdate extends MessageContent {
  String playerId;
  List<String> trackFieldsId;

  static IntentionUpdate fromJson(Map<String, dynamic> json) =>
      _$IntentionUpdateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$IntentionUpdateToJson(this);
  }
}
