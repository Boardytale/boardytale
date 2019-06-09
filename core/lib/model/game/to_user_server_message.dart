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

  GetHeroesOfPlayer get getHeroesOfPlayerMessage => GetHeroesOfPlayer.fromJson(json.decode(content));

  void addHeroesAndUnits(List<GameHeroCreateEnvelope> responseHeroes, List<UnitTypeCompiled> responseUnits) {
    content = json.encode(getHeroesOfPlayerMessage
      ..responseHeroes = responseHeroes
      ..responseUnits = responseUnits);
  }

  factory ToUserServerMessage.fromPlayerEmail(String requestPlayerEmail) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getHeroesOfPlayer
      ..content = json.encode((GetHeroesOfPlayer()..requestPlayerEmail = requestPlayerEmail).toJson());
  }

  // ---

  ListOfHeroes get getListOfHeroes => ListOfHeroes.fromJson(json.decode(content));

  void addHeroes(List<GameHeroCreateEnvelope> responseHeroes) {
    content = json.encode(getListOfHeroes..responseHeroes = responseHeroes);
  }

  factory ToUserServerMessage.requestHeroesToCreate() {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getHeroesToCreate
      ..content = "{}";
  }
  // ---

  CreateHero get getCreateHeroMessage => CreateHero.fromJson(json.decode(content));

  void addHero(GameHeroCreateEnvelope responseHero) {
    content = json.encode(getCreateHeroMessage..responseHero = responseHero);
  }

  factory ToUserServerMessage.createHero(CreateHero createHero) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.createHero
      ..content = json.encode(createHero.toJson());
  }
  // ---

  ListOfHeroesOfPlayer get getListOfHeroesOfPlayer => ListOfHeroesOfPlayer.fromJson(json.decode(content));

  void addHeroesOfPlayer(List<GameHeroCreateEnvelope> responseHeroes) {
    content = json.encode(getListOfHeroesOfPlayer..responseHeroes = responseHeroes);
  }

  // use list of heroes for request
  factory ToUserServerMessage.requestMyHeroes(String innerToken) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getMyHeroes
      ..content = json.encode((ListOfHeroesOfPlayer()..innerToken = innerToken).toJson());
  }
}

@Typescript()
enum OnUserServerAction {
  @JsonValue('getUseresByInnerToken')
  getUseresByInnerToken,
  @JsonValue('getHeroesOfPlayer')
  getHeroesOfPlayer,
  @JsonValue('getHeroesToCreate')
  getHeroesToCreate,
  @JsonValue('createHero')
  createHero,
  @JsonValue('getMyHeroes')
  getMyHeroes,
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

@JsonSerializable()
class GetHeroesOfPlayer extends MessageContent {
  String requestPlayerEmail;
  List<GameHeroCreateEnvelope> responseHeroes;
  List<UnitTypeCompiled> responseUnits;

  static GetHeroesOfPlayer fromJson(Map<String, dynamic> json) => _$GetHeroesOfPlayerFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GetHeroesOfPlayerToJson(this);
  }
}

@JsonSerializable()
class ListOfHeroes extends MessageContent {
  List<GameHeroCreateEnvelope> responseHeroes;

  static ListOfHeroes fromJson(Map<String, dynamic> json) => _$ListOfHeroesFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ListOfHeroesToJson(this);
  }
}

@JsonSerializable()
class ListOfHeroesOfPlayer extends MessageContent {
  List<GameHeroCreateEnvelope> responseHeroes;
  String innerToken;

  static ListOfHeroesOfPlayer fromJson(Map<String, dynamic> json) => _$ListOfHeroesOfPlayerFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ListOfHeroesOfPlayerToJson(this);
  }
}

@JsonSerializable()
class CreateHero extends MessageContent {
  String name;
  String typeName;
  String innerToken;
  GameHeroCreateEnvelope responseHero;

  static CreateHero fromJson(Map<String, dynamic> json) => _$CreateHeroFromJson(json);

  Map<String, dynamic> toJson() {
    return _$CreateHeroToJson(this);
  }
}
