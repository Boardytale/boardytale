part of model;

@JsonSerializable()
class ToHeroServerMessage {
  OnHeroServerAction message;
  String content;

  ToHeroServerMessage();

  Map<String, dynamic> toJson() {
    return _$ToHeroServerMessageToJson(this);
  }

  static ToHeroServerMessage fromJson(Map<String, dynamic> json) =>
      _$ToHeroServerMessageFromJson(json);

  // ---

  GetHeroesOfPlayer get getHeroesOfPlayerMessage => GetHeroesOfPlayer.fromJson(json.decode(content));

  void addHeroes(List<GameHeroCreateEnvelope> responseHeroes){
    content = json.encode(getHeroesOfPlayerMessage..responseHeroes = responseHeroes);
  }

  factory ToHeroServerMessage.fromPlayerEmail(String requestPlayerEmail) {
    return ToHeroServerMessage()
      ..message = OnHeroServerAction.getHeroesOfPlayer
      ..content = json.encode((GetHeroesOfPlayer()
            ..requestPlayerEmail = requestPlayerEmail)
          .toJson());
  }

// ---
}

@Typescript()
enum OnHeroServerAction {
  @JsonValue('getHeroesOfPlayer')
  getHeroesOfPlayer,
}

@JsonSerializable()
class GetHeroesOfPlayer extends MessageContent {
  String requestPlayerEmail;
  List<GameHeroCreateEnvelope> responseHeroes;

  static GetHeroesOfPlayer fromJson(Map<String, dynamic> json) =>
      _$GetHeroesOfPlayerFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GetHeroesOfPlayerToJson(this);
  }
}
