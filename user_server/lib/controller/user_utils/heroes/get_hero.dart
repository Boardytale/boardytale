part of user_utils;

Future<Hero> getFirstHero(int userId, ManagedContext context) {
  var heroesQuery = Query<Hero>(context)..where((hero) => hero.user.id).equalTo(userId);
  return heroesQuery.fetchOne();
}

Future<Response> getMyHeroes(core.ToUserServerMessage message, ManagedContext context) async {
  var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.innerToken);
  User user = await query.fetchOne();
  if (user != null) {
    var heroesQuery = Query<Hero>(context)..where((hero) => hero.user.id).equalTo(user.id);

    List<Hero> heroesData = await heroesQuery.fetch();
    message.addHeroesOfPlayer(heroesData
        .map((Hero heroData) {
          return core.HeroEnvelope.fromJson(heroData.heroData.data as Map<String, dynamic>).gameHeroEnvelope;
        })
        .where((hero) => hero != null)
        .toList());
    return Response.ok(message.toJson());
  } else {
    return Response.badRequest(body: {"message": "bad inner token"});
  }
}

Future<Response> getMyHeroDetail(core.ToUserServerMessage message, ManagedContext context) async {
  core.GetHeroDetail getHeroDetail = message.getHeroDetail;
  if (message.innerToken == null || getHeroDetail.heroId == null) {
    return Response.badRequest(body: "bad inner token or heroId");
  }
  int heroIdInt = int.tryParse(getHeroDetail.heroId);
  if (heroIdInt == null) {
    return Response.badRequest(body: "bad format of heroId");
  }

  var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.innerToken);
  User user = await query.fetchOne();
  if (user != null) {
    var heroesQuery = Query<Hero>(context)
      ..where((hero) => hero.user.id).equalTo(user.id)
      ..where((hero) => hero.heroId).equalTo(heroIdInt);

    Hero heroData = await heroesQuery.fetchOne();
    if (heroData == null) {
      return Response.notFound();
    }
    core.HeroEnvelope heroEnvelope = core.HeroEnvelope.fromJson(heroData.heroData.data as Map<String, dynamic>);
    var gainQuery = Query<HeroAfterGameGain>(context)
      ..where((gain) => gain.hero.heroId).equalTo(heroData.heroId);
    List<HeroAfterGameGain> gains = await gainQuery.fetch();
    List<core.HeroAfterGameGain> coreGains = gains.map((gain){
      return core.HeroAfterGameGain.fromJson(gain.gainData.data as Map<String, dynamic>)..id = gain.gainId;
    }).toList();
    Map<String, core.ItemEnvelope> items = {};
    coreGains.forEach((gain){
      gain.itemTypeNames.forEach((typeName){
        if(!items.containsKey(typeName)){
          items[typeName] = itemsData[typeName];
        }
      });
    });
    message.addHeroDetail(heroEnvelope, coreGains, items);
    return Response.ok(message.toJson());
  } else {
    return Response.badRequest(body: {"message": "bad inner token"});
  }
}
