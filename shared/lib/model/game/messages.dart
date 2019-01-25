part of model;

@JsonSerializable()
class ToClientMessage {
  OnClientAction message;
  String content;
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
}

@JsonSerializable()
class RefreshLobbyList extends MessageContent {
  List<LobbyTale> lobbies;
}
