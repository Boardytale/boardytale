part of model;

// TODO: rethink to split to outer and inner messages

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

  void addHeroesAndUnitsToStartingUnits(List<GameHeroEnvelope> responseHeroes, List<UnitTypeCompiled> responseUnits) {
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

  void addHeroes(List<GameHeroEnvelope> responseHeroes) {
    content = json.encode(getListOfHeroes..responseHeroes = responseHeroes);
  }

  factory ToUserServerMessage.createRequestForListOfDefaultHeroesToCreate() {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getHeroesToCreate
      ..content = "{}";
  }
  // ---

  CreateHeroData get getCreateHeroData => CreateHeroData.fromJson(json.decode(content));

  void addHero(GameHeroEnvelope responseHero) {
    content = json.encode(getCreateHeroData..responseHero = responseHero);
  }

  factory ToUserServerMessage.createCreateHeroData(CreateHeroData createHero) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.createHero
      ..content = json.encode(createHero.toJson());
  }
  // ---

  ListOfHeroesOfPlayer get getListOfHeroesOfPlayer => ListOfHeroesOfPlayer.fromJson(json.decode(content));

  void addHeroesOfPlayer(List<GameHeroEnvelope> responseHeroes) {
    content = json.encode(getListOfHeroesOfPlayer..responseHeroes = responseHeroes);
  }

  // use list of heroes for request
  factory ToUserServerMessage.createRequestForMyHeroes(String innerToken) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getMyHeroes
      ..content = json.encode((ListOfHeroesOfPlayer()..innerToken = innerToken).toJson());
  }
  // ---

  HeroAfterGameGain get getHeroAfterGameGain => HeroAfterGameGain.fromJson(json.decode(content));

  factory ToUserServerMessage.createHeroAfterGameGain(HeroAfterGameGain gain) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.setHeroAfterGameGain
      ..content = json.encode(gain.toJson());
  }

  // ---

  User get getUpdateUser => User.fromJson(json.decode(content));

  factory ToUserServerMessage.createUpdateUser(User user) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.updateUser
      ..content = json.encode(user.toJson());
  }
  // ---

  GetHeroDetail get getHeroDetail => GetHeroDetail.fromJson(json.decode(content));

  void addHeroDetail(HeroEnvelope responseHero) {
    content = json.encode(getHeroDetail..responseHero = responseHero);
  }

  factory ToUserServerMessage.createGetHeroDetail(String innerToken, String heroId) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getHeroDetail
      ..content = json.encode((GetHeroDetail()..innerToken = innerToken..heroId = heroId).toJson());
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
  @JsonValue('setHeroAfterGameGain')
  setHeroAfterGameGain,
  @JsonValue('updateUser')
  updateUser,
  @JsonValue('getHeroDetail')
  getHeroDetail,
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
  List<GameHeroEnvelope> responseHeroes;
  List<UnitTypeCompiled> responseUnits;

  static HeroesAndUnitsOfPlayer fromJson(Map<String, dynamic> json) => _$HeroesAndUnitsOfPlayerFromJson(json);

  Map<String, dynamic> toJson() {
    return _$HeroesAndUnitsOfPlayerToJson(this);
  }
}

@JsonSerializable()
class ListOfHeroes extends MessageContent {
  List<GameHeroEnvelope> responseHeroes;

  static ListOfHeroes fromJson(Map<String, dynamic> json) => _$ListOfHeroesFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ListOfHeroesToJson(this);
  }
}

@JsonSerializable()
class ListOfHeroesOfPlayer extends MessageContent {
  List<GameHeroEnvelope> responseHeroes;
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
  GameHeroEnvelope responseHero;

  static CreateHeroData fromJson(Map<String, dynamic> json) => _$CreateHeroDataFromJson(json);

  Map<String, dynamic> toJson() {
    return _$CreateHeroDataToJson(this);
  }
}

@JsonSerializable()
class HeroAfterGameGain extends MessageContent {
  int xp;
  int money;
  List<ItemEnvelope> items;
  String heroId;

  static HeroAfterGameGain fromJson(Map<String, dynamic> json) => _$HeroAfterGameGainFromJson(json);

  Map<String, dynamic> toJson() {
    return _$HeroAfterGameGainToJson(this);
  }
}

@JsonSerializable()
class GetHeroDetail extends MessageContent {
  String heroId;
  String innerToken;
  HeroEnvelope responseHero;

  static GetHeroDetail fromJson(Map<String, dynamic> json) => _$GetHeroDetailFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GetHeroDetailToJson(this);
  }
}
