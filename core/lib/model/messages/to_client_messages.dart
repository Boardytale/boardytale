part of model;

@JsonSerializable()
class ToClientMessage {
  OnClientAction message;
  String content;

  ToClientMessage();

  static ToClientMessage fromJson(Map<String, dynamic> json) => _$ToClientMessageFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ToClientMessageToJson(this);
  }

  // ---

  RefreshLobbyList get refreshLobbyListMessage => RefreshLobbyList.fromJson(json.decode(content));

  factory ToClientMessage.createLobbyList(List<OpenedLobby> lobbyList) {
    return ToClientMessage()
      ..message = OnClientAction.refreshLobbyList
      ..content = json.encode((RefreshLobbyList()..lobbies = lobbyList).toJson());
  }

  // ---

  SetNavigationState get navigationStateMessage => SetNavigationState.fromJson(json.decode(content));

  factory ToClientMessage.createSetNavigationState(GameNavigationState newState, {bool destroyCurrentTale: false}) {
    return ToClientMessage()
      ..message = OnClientAction.setNavigationState
      ..content = json.encode((SetNavigationState()
            ..newState = newState
            ..destroyCurrentTale = destroyCurrentTale)
          .toJson());
  }

  // ---

  GetGamesToCreate get getGamesToCreateMessage => GetGamesToCreate.fromJson(json.decode(content));

  factory ToClientMessage.createGamesToCreateMessage(List<LobbyTale> lobbyList) {
    return ToClientMessage()
      ..message = OnClientAction.getGamesToCreate
      ..content = json.encode((GetGamesToCreate()..games = lobbyList).toJson());
  }

  // ---

  User get getCurrentUser => User.fromJson(json.decode(content));

  factory ToClientMessage.createSetCurrentUser(User user) {
    return ToClientMessage()
      ..message = OnClientAction.setCurrentUser
      ..content = json.encode(user.toJson());
  }

  // ---

  OpenedLobby get getOpenedLobbyData => OpenedLobby.fromJson(json.decode(content));

  factory ToClientMessage.createOpenedLobby(OpenedLobby lobby) {
    return ToClientMessage()
      ..message = OnClientAction.openedLobbyData
      ..content = json.encode(lobby.toJson());
  }

  // ---

  TaleData get getTaleDataMessage => TaleData.fromJson(json.decode(content));

  factory ToClientMessage.createTaleData(Tale data, Assets assets, String playerIdOnThisClientMachine) {
    return ToClientMessage()
      ..message = OnClientAction.taleData
      ..content = json.encode((TaleData()
            ..tale = data
            ..playerIdOnThisClientMachine = playerIdOnThisClientMachine
            ..assets = assets)
          .toJson());
  }

  // ---

  TaleUpdate get getUnitCreateOrUpdate => TaleUpdate.fromJson(json.decode(content));

  factory ToClientMessage.createUnitCreateOrUpdate(TaleUpdate taleUpdate) {
    return ToClientMessage()
      ..message = OnClientAction.unitCreateOrUpdate
      ..content = json.encode(taleUpdate.toJson());
  }

  // ---

  UnitDelete get getUnitDelete => UnitDelete.fromJson(json.decode(content));

  factory ToClientMessage.createUnitDelete(List<UnitDeleteAction> actions) {
    return ToClientMessage()
      ..message = OnClientAction.unitDelete
      ..content = json.encode((UnitDelete()..actions = actions).toJson());
  }

  // ---

  CancelOnField get getCancelOnField => CancelOnField.fromJson(json.decode(content));

  factory ToClientMessage.createCancelOnField(List<CancelOnFieldAction> actions) {
    return ToClientMessage()
      ..message = OnClientAction.cancelOnField
      ..content = json.encode((CancelOnField()..actions = actions).toJson());
  }

  // ---

  IntentionUpdate get getIntentionUpdate => IntentionUpdate.fromJson(json.decode(content));

  factory ToClientMessage.createIntentionUpdate(String playerId, List<String> trackFieldsId) {
    return ToClientMessage()
      ..message = OnClientAction.intentionUpdate
      ..content = json.encode((IntentionUpdate()
            ..playerId = playerId
            ..trackFieldsId = trackFieldsId)
          .toJson());
  }
  // ---

  GameHeroEnvelope get getCurrentHero => GameHeroEnvelope.fromJson(json.decode(content));

  factory ToClientMessage.createSetCurrentHero(GameHeroEnvelope hero) {
    return ToClientMessage()
      ..message = OnClientAction.setCurrentHero
      ..content = json.encode(hero.toJson());
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
  @JsonValue('playersOnMove')
  playersOnMove,
  @JsonValue('addUnitType')
  addUnitType,
  @JsonValue('setCurrentHero')
  setCurrentHero
}


@JsonSerializable()
class SetNavigationState {
  GameNavigationState newState;
  bool destroyCurrentTale = false;

  static SetNavigationState fromJson(Map<String, dynamic> json) => _$SetNavigationStateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$SetNavigationStateToJson(this);
  }
}

@JsonSerializable()
class RefreshLobbyList {
  List<OpenedLobby> lobbies;

  static RefreshLobbyList fromJson(Map<String, dynamic> json) => _$RefreshLobbyListFromJson(json);

  Map<String, dynamic> toJson() {
    return _$RefreshLobbyListToJson(this);
  }
}

@JsonSerializable()
class GetGamesToCreate {
  List<LobbyTale> games;

  static GetGamesToCreate fromJson(Map<String, dynamic> json) => _$GetGamesToCreateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GetGamesToCreateToJson(this);
  }
}

@JsonSerializable()
class TaleData {
  Tale tale;
  Assets assets;
  String playerIdOnThisClientMachine;

  static TaleData fromJson(Map<String, dynamic> json) => _$TaleDataFromJson(json);

  Map<String, dynamic> toJson() {
    return _$TaleDataToJson(this);
  }
}

@JsonSerializable()
class TaleUpdate {
  List<UnitCreateOrUpdateAction> actions;
  Iterable<String> playerOnMoveIds;
  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  List<UnitType> newUnitTypesToTale;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  List<String> unitToRemoveIds;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  Assets newAssetsToTale;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  List<Player> newPlayersToTale;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  String removePlayerId;

  @TypescriptOptional()
  @JsonKey(includeIfNull: false)
  ShowBanterAction banterAction;

  static TaleUpdate fromJson(Map<String, dynamic> json) => _$TaleUpdateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$TaleUpdateToJson(this);
  }
}

@JsonSerializable()
class UnitDelete {
  List<UnitDeleteAction> actions;

  static UnitDelete fromJson(Map<String, dynamic> json) => _$UnitDeleteFromJson(json);

  Map<String, dynamic> toJson() {
    return _$UnitDeleteToJson(this);
  }
}

@JsonSerializable()
class CancelOnField {
  List<CancelOnFieldAction> actions;

  static CancelOnField fromJson(Map<String, dynamic> json) => _$CancelOnFieldFromJson(json);

  Map<String, dynamic> toJson() {
    return _$CancelOnFieldToJson(this);
  }
}

@JsonSerializable()
class IntentionUpdate {
  String playerId;
  List<String> trackFieldsId;

  static IntentionUpdate fromJson(Map<String, dynamic> json) => _$IntentionUpdateFromJson(json);

  Map<String, dynamic> toJson() {
    return _$IntentionUpdateToJson(this);
  }
}

