part of model;

@JsonSerializable()
class ToClientMessage {
  OnClientAction message;
  String content;

  ToClientMessage();

  SetNavigationState get navigationStateMessage => SetNavigationState.fromJson(json.decode(content));
  RefreshLobbyList get refreshLobbyList => RefreshLobbyList.fromJson(json.decode(content));

  factory ToClientMessage.fromSetNavigationState(GameNavigationState newState){
    return ToClientMessage()
      ..message = OnClientAction.setNavigationState
      ..content = json.encode((SetNavigationState()..newState=newState).toJson());
  }

  static ToClientMessage fromJson(Map<String, dynamic> json) => _$ToClientMessageFromJson(json);
  Map<String, dynamic> toJson(){
    return _$ToClientMessageToJson(this);
  }

}

@Typescript()
enum OnClientAction {
  @JsonValue('setNavigationState')
  setNavigationState,
  @JsonValue('refreshLobbyList')
  refreshLobbyList,
}

abstract class MessageContent {}

@JsonSerializable()
class SetNavigationState extends MessageContent {
  GameNavigationState newState;
  static SetNavigationState fromJson(Map<String, dynamic> json) => _$SetNavigationStateFromJson(json);
  Map<String, dynamic> toJson(){
    return _$SetNavigationStateToJson(this);
  }

}

@JsonSerializable()
class RefreshLobbyList extends MessageContent {
  List<LobbyTale> lobbies;
  static RefreshLobbyList fromJson(Map<String, dynamic> json) => _$RefreshLobbyListFromJson(json);
  Map<String, dynamic> toJson(){
    return _$RefreshLobbyListToJson(this);
  }
}
