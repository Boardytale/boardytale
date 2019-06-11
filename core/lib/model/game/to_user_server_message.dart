part of model;

@JsonSerializable()
class ToUserServerMessage {
  OnUserServerAction message;
  String content;
  String error;

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

  factory ToUserServerMessage.createGetUserByInnerToken(String innerToken) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getUserByInnerToken
      ..content = json.encode((GetUserByInnerToken()..innerToken = innerToken).toJson());
  }

  // ---

  HeroesAndUnitsOfPlayer get getStartingUnits => HeroesAndUnitsOfPlayer.fromJson(json.decode(content));

  void addHeroesAndUnitsToStartingUnits(List<GameHeroCreateEnvelope> responseHeroes, List<UnitTypeCompiled> responseUnits) {
    content = json.encode(getStartingUnits
      ..responseHeroes = responseHeroes
      ..responseUnits = responseUnits);
  }

  factory ToUserServerMessage.createGetStartingUnits(String playerEmail, String heroId) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getStartingUnits
      ..content = json.encode((HeroesAndUnitsOfPlayer()..requestedPlayerEmail = playerEmail..requestedHeroId = heroId).toJson());
  }

  // ---

  ListOfHeroes get getListOfHeroes => ListOfHeroes.fromJson(json.decode(content));

  void addHeroes(List<GameHeroCreateEnvelope> responseHeroes) {
    content = json.encode(getListOfHeroes..responseHeroes = responseHeroes);
  }

  factory ToUserServerMessage.createRequestForListOfDefaultHeroesToCreate() {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getHeroesToCreate
      ..content = "{}";
  }
  // ---

  CreateHeroData get getCreateHeroData => CreateHeroData.fromJson(json.decode(content));

  void addHero(GameHeroCreateEnvelope responseHero) {
    content = json.encode(getCreateHeroData..responseHero = responseHero);
  }

  factory ToUserServerMessage.createCreateHeroData(CreateHeroData createHero) {
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
  factory ToUserServerMessage.createRequestForMyHeroes(String innerToken) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getMyHeroes
      ..content = json.encode((ListOfHeroesOfPlayer()..innerToken = innerToken).toJson());
  }
}

@Typescript()
enum OnUserServerAction {
  @JsonValue('getUserByInnerToken')
  getUserByInnerToken,
  @JsonValue('getStartingUnits')
  getStartingUnits,
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
class HeroesAndUnitsOfPlayer extends MessageContent {
  String requestedPlayerEmail;
  String requestedHeroId;
  List<GameHeroCreateEnvelope> responseHeroes;
  List<UnitTypeCompiled> responseUnits;

  static HeroesAndUnitsOfPlayer fromJson(Map<String, dynamic> json) => _$HeroesAndUnitsOfPlayerFromJson(json);

  Map<String, dynamic> toJson() {
    return _$HeroesAndUnitsOfPlayerToJson(this);
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
class CreateHeroData extends MessageContent {
  String name;
  String typeName;
  String innerToken;
  GameHeroCreateEnvelope responseHero;

  static CreateHeroData fromJson(Map<String, dynamic> json) => _$CreateHeroFromJson(json);

  Map<String, dynamic> toJson() {
    return _$CreateHeroToJson(this);
  }
}
