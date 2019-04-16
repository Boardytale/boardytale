part of model;

@JsonSerializable()
class ToUserServerMessage {
  OnUserServerAction message;
  String content;

  ToUserServerMessage();

  Map<String, dynamic> toJson() {
    return _$ToUserServerMessageToJson(this);
  }

  static ToUserServerMessage fromJson(Map<String, dynamic> json) => _$ToUserServerMessageFromJson(json);

  // ---

  GetUserByInnerToken get getUser => GetUserByInnerToken.fromJson(json.decode(content));

  void addUser(User responseUser) {
    content = json.encode(getUser..user = responseUser);
  }

  factory ToUserServerMessage.fromInnerToken(String innerToken) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getUseresByInnerToken
      ..content = json.encode((GetUserByInnerToken()..innerToken = innerToken).toJson());
  }

// ---
}

@Typescript()
enum OnUserServerAction {
  @JsonValue('getUseresByInnerToken')
  getUseresByInnerToken,
}

@JsonSerializable()
class GetUserByInnerToken extends MessageContent {
  User user;
  String innerToken;

  static GetUserByInnerToken fromJson(Map<String, dynamic> json) => _$GetUserByInnerTokenFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GetUserByInnerTokenToJson(this);
  }
}
