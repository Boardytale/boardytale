part of model;

// TODO: rethink to split to outer and inner messages

@JsonSerializable()
class ToUserServerMessage {
  OnUserServerAction message;
  String content;
  String error;
  String innerToken;

  ToUserServerMessage();

  Map<String, dynamic> toJson() {
    return _$ToUserServerMessageToJson(this);
  }

  static ToUserServerMessage fromJson(Map<String, dynamic> json) => _$ToUserServerMessageFromJson(json);

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

  List<GameHeroEnvelope> get getListOfHeroesOfPlayer{
    List<dynamic> decoded = json.decode(content);
    return decoded.map((heroData) {
        return GameHeroEnvelope.fromJson(heroData);
      }).toList();
  }

  void addHeroesOfPlayer(List<GameHeroEnvelope> responseHeroes) {
    content = json.encode(responseHeroes.map((hero)=>hero.toJson()).toList());
  }

  // use list of heroes for request
  factory ToUserServerMessage.createRequestForMyHeroes() {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getMyHeroes
      ..content = "";
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

  void addHeroDetail(HeroEnvelope responseHero, List<HeroAfterGameGain> gains, Map<String, ItemEnvelope> gainItems) {
    content = json.encode(getHeroDetail
      ..responseHero = responseHero
      ..gains = gains
      ..gainItems = gainItems);
  }

  factory ToUserServerMessage.createGetHeroDetail(String innerToken, String heroId) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getHeroDetail
      ..content = json.encode((GetHeroDetail()..heroId = heroId).toJson());
  }

  // ---

  HeroUpdate get getHeroUpdate => HeroUpdate.fromJson(json.decode(content));

  void addHeroDetailToUpdate(HeroEnvelope responseHero) {
    content = json.encode(getHeroUpdate..responseHero = responseHero);
  }

  factory ToUserServerMessage.createHeroUpdate(HeroUpdate update) {
    return ToUserServerMessage()
      ..message = OnUserServerAction.updateHero
      ..content = json.encode(update.toJson());
  }

  // ---

  List<ItemEnvelope> get getShopItems {
    List<dynamic> decoded = json.decode(content);
    return decoded.map((itemData) {
      return ItemEnvelope.fromJson(itemData);
    }).toList();
  }

  void addItemsToShop(List<ItemEnvelope> items) {
    content = json.encode(items.map((item)=>item.toJson()).toList());
  }

  factory ToUserServerMessage.createRequestForShopItems() {
    return ToUserServerMessage()
      ..message = OnUserServerAction.getShopItems
      ..content = "";
  }

}

@Typescript()
enum OnUserServerAction {
  @JsonValue('getHeroesToCreate')
  getHeroesToCreate,
  @JsonValue('createHero')
  createHero,
  @JsonValue('getMyHeroes')
  getMyHeroes,
  @JsonValue('updateUser')
  updateUser,
  @JsonValue('getHeroDetail')
  getHeroDetail,
  @JsonValue('updateHero')
  updateHero,
  @JsonValue('getShopItems')
  getShopItems,
}

@JsonSerializable()
class ListOfHeroes {
  List<GameHeroEnvelope> responseHeroes;

  static ListOfHeroes fromJson(Map<String, dynamic> json) => _$ListOfHeroesFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ListOfHeroesToJson(this);
  }
}

@JsonSerializable()
class CreateHeroData {
  String name;
  String typeName;
  GameHeroEnvelope responseHero;

  static CreateHeroData fromJson(Map<String, dynamic> json) => _$CreateHeroDataFromJson(json);

  Map<String, dynamic> toJson() {
    return _$CreateHeroDataToJson(this);
  }
}

@JsonSerializable()
class GetHeroDetail {
  String heroId;
  HeroEnvelope responseHero;
  List<HeroAfterGameGain> gains;
  Map<String, ItemEnvelope> gainItems;

  static GetHeroDetail fromJson(Map<String, dynamic> json) => _$GetHeroDetailFromJson(json);

  Map<String, dynamic> toJson() {
    return _$GetHeroDetailToJson(this);
  }
}
