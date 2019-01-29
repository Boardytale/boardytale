part of model;

@JsonSerializable()
class ToGameServerMessage {
  OnServerAction message;
  String content;

  ToGameServerMessage();
  Map<String, dynamic> toJson(){
    return _$ToGameServerMessageToJson(this);
  }
  static ToGameServerMessage fromJson(Map<String, dynamic> json) => _$ToGameServerMessageFromJson(json);

  factory ToGameServerMessage.fromGoToState(GameNavigationState newState){
    return ToGameServerMessage()
        ..message = OnServerAction.goToState
        ..content = json.encode((GoToState()..newState=newState).toJson());
  }

  factory ToGameServerMessage.init() {
    return ToGameServerMessage()
      ..content = "{}"
      ..message = OnServerAction.init;
  }

  GoToState get goToState => GoToState.fromJson(json.decode(content));
  InitMessage get initMessage => InitMessage.fromJson(json.decode(content));

}

@Typescript()
enum OnServerAction {
@JsonValue('goToState')
goToState,
@JsonValue('init')
init,
}


@JsonSerializable()
class GoToState extends MessageContent {
  GameNavigationState newState;

  static GoToState fromJson(Map<String, dynamic> json) => _$GoToStateFromJson(json);
  Map<String, dynamic> toJson(){
    return _$GoToStateToJson(this);
  }
}

@JsonSerializable()
class InitMessage extends MessageContent {
  String someContent;

  static InitMessage fromJson(Map<String, dynamic> json) => _$InitMessageFromJson(json);
  Map<String, dynamic> toJson(){
    return _$InitMessageToJson(this);
  }
}

