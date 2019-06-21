part of user_utils;

Future<Response> createHero(core.ToUserServerMessage message, ManagedContext context) async {
  core.CreateHeroData heroToCreate = message.getCreateHeroData;
  var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.innerToken);
  User user = await query.fetchOne();
  if (user != null) {
    List<core.HeroEnvelope> heroEnvelope = heroesData.where((hero) {
      return hero.gameHeroEnvelope.type.name == heroToCreate.typeName;
    }).toList();

    if (heroEnvelope.isEmpty) {
      return Response.badRequest(body: "something wrong with data - probably not existing type name");
    }

    core.HeroEnvelope copyOfHeroEnvelope = core.HeroEnvelope.fromJson(heroEnvelope.first.toJson());
    copyOfHeroEnvelope.gameHeroEnvelope.name = heroToCreate.name;

    core.Hero coreHero = core.Hero(copyOfHeroEnvelope, itemsData);
    coreHero.updateType();

    Hero newHero = Hero()
      ..level = 0
      ..user = user
      ..dataFormatVersion = 0
      ..heroData = Document({});
    newHero = await (Query<Hero>(context)..values = newHero).insert();
    copyOfHeroEnvelope.gameHeroEnvelope.id = newHero.heroId.toString();

    var heroQuery = Query<Hero>(context)..where((hero) => hero.heroId).equalTo(newHero.heroId);
    heroQuery.values.heroData = Document(copyOfHeroEnvelope.toJson());
    newHero = await heroQuery.updateOne();
    message.addHero(core.GameHeroEnvelope.fromJson(newHero.heroData.data as Map<String, dynamic>));
    return Response.ok(message.toJson());
  }
  else{
    return Response.badRequest(body: {"message": "bad inner token"});
  }
}

