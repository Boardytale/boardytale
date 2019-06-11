part of user_utils;

Future<Response> createHero(core.ToUserServerMessage message, ManagedContext context) async {
  core.CreateHeroData heroToCreate = message.getCreateHeroData;
  var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.getUser.innerToken);
  User user = await query.fetchOne();
  if (user != null) {
    List<core.GameHeroCreateEnvelope> heroEnvelope = heroesData.where((hero) {
      return hero.type.name == heroToCreate.typeName;
    }).toList();

    if (heroEnvelope.isEmpty) {
      return Response.badRequest(body: "something wrong with data - probably not existing type name");
    }

    core.GameHeroCreateEnvelope copyOfHeroEnvelope = core.GameHeroCreateEnvelope.fromJson(heroEnvelope.first.toJson());
    copyOfHeroEnvelope.name = heroToCreate.name;

    Hero newHero = Hero()
      ..level = 0
      ..user = user
      ..dataFormatVersion = 0
      ..heroData = Document({});
    newHero = await (Query<Hero>(context)..values = newHero).insert();
    copyOfHeroEnvelope.id = newHero.heroId.toString();

    var heroQuery = Query<Hero>(context)..where((hero) => hero.heroId).equalTo(newHero.heroId);
    heroQuery.values.heroData = Document(copyOfHeroEnvelope.toJson());
    newHero = await heroQuery.updateOne();
    message.addHero(core.GameHeroCreateEnvelope.fromJson(newHero.heroData.data as Map<String, dynamic>));
    return Response.ok(message.toJson());
  }
  else{
    return Response.badRequest(body: {"message": "bad inner token"});
  }
}

