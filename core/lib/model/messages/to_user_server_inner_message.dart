part of model;

// TODO: rethink to split to outer and inner messages

@JsonSerializable()
class ToUserServerInnerMessage {
  OnUserServerInnerAction message;
  String content;
  String error;

  ToUserServerInnerMessage();

  Map<String, dynamic> toJson() {
    return _$ToUserServerInnerMessageToJson(this);
  }

  static ToUserServerInnerMessage fromJson(Map<String, dynamic> json) => _$ToUserServerInnerMessageFromJson(json);

  // ---

  GetUserByInnerToken get getUser => GetUserByInnerToken.fromJson(json.decode(content));

  void addUser(User responseUser) {
    content = json.encode(getUser..user = responseUser);
  }

  factory ToUserServerInnerMessage.createGetUserByInnerToken(String innerToken) {
    return ToUserServerInnerMessage()
      ..message = OnUserServerInnerAction.getUserByInnerToken
      ..content = json.encode((GetUserByInnerToken()..innerToken = innerToken).toJson());
  }

  // ---

  HeroesAndUnitsOfPlayer get getStartingUnits => HeroesAndUnitsOfPlayer.fromJson(json.decode(content));

  void addHeroesAndUnitsToStartingUnits(List<GameHeroEnvelope> responseHeroes, List<UnitTypeCompiled> responseUnits) {
    content = json.encode(getStartingUnits
      ..responseHeroes = responseHeroes
      ..responseUnits = responseUnits);
  }

  factory ToUserServerInnerMessage.createGetStartingUnits(String playerEmail, String heroId) {
    return ToUserServerInnerMessage()
      ..message = OnUserServerInnerAction.getStartingUnits
      ..content = json.encode((HeroesAndUnitsOfPlayer()
            ..requestedPlayerEmail = playerEmail
            ..requestedHeroId = heroId)
          .toJson());
  }

  // ---

  HeroAfterGameGain get getHeroAfterGameGain => HeroAfterGameGain.fromJson(json.decode(content));

  factory ToUserServerInnerMessage.createHeroAfterGameGain(HeroAfterGameGain gain) {
    return ToUserServerInnerMessage()
      ..message = OnUserServerInnerAction.setHeroAfterGameGain
      ..content = json.encode(gain.toJson());
  }

}

@Typescript()
enum OnUserServerInnerAction {
  @JsonValue('getUserByInnerToken')
  getUserByInnerToken,
  @JsonValue('getStartingUnits')
  getStartingUnits,
  @JsonValue('setHeroAfterGameGain')
  setHeroAfterGameGain,
}

@JsonSerializable()
class GetUserByInnerToken {
  User user;
  String innerToken;

  static GetUserByInnerToken fromJson(Map<String, dynamic> json) => _$GetUserByInnerTokenFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GetUserByInnerTokenToJson(this);
  }
}

@JsonSerializable()
class HeroesAndUnitsOfPlayer {
  String requestedPlayerEmail;
  String requestedHeroId;
  List<GameHeroEnvelope> responseHeroes;
  List<UnitTypeCompiled> responseUnits;

  static HeroesAndUnitsOfPlayer fromJson(Map<String, dynamic> json) => _$HeroesAndUnitsOfPlayerFromJson(json);

  Map<String, dynamic> toJson() {
    return _$HeroesAndUnitsOfPlayerToJson(this);
  }
}
