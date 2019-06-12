part of user_utils;

Future<Response> getMyHeroes(core.ToUserServerMessage message, ManagedContext context) async {
  var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.getUser.innerToken);
  User user = await query.fetchOne();
  if (user != null) {
    var heroesQuery = Query<Hero>(context)..where((hero) => hero.user.id).equalTo(user.id);

    List<Hero> heroesData = await heroesQuery.fetch();
    message.addHeroesOfPlayer(heroesData.map((Hero heroData){
      return core.HeroEnvelope.fromJson(heroData.heroData.data as Map<String, dynamic>).gameHeroEnvelope;
    }).toList());
    return Response.ok(message.toJson());
  }
  else{
    return Response.badRequest(body: {"message": "bad inner token"});
  }
}

Future<Response> getMyHeroDetail(core.ToUserServerMessage message, ManagedContext context) async {
  core.GetHeroDetail getHeroDetail = message.getHeroDetail;
  if(getHeroDetail.innerToken == null || getHeroDetail.heroId == null){
    return Response.badRequest(body: "bad inner token or heroId");
  }
  int heroIdInt = int.tryParse(getHeroDetail.heroId);
  if(heroIdInt == null){
    return Response.badRequest(body: "bad format of heroId");
  }

  var query = Query<User>(context)..where((u) => u.innerToken).equalTo(getHeroDetail.innerToken);
  User user = await query.fetchOne();
  if (user != null) {
    var heroesQuery = Query<Hero>(context)
      ..where((hero) => hero.user.id).equalTo(user.id)
      ..where((hero) => hero.heroId).equalTo(heroIdInt)
    ;

    Hero heroData = await heroesQuery.fetchOne();
    message.addHeroDetail(core.HeroEnvelope.fromJson(heroData.heroData.data as Map<String, dynamic>));
    return Response.ok(message.toJson());
  }
  else{
    return Response.badRequest(body: {"message": "bad inner token"});
  }
}

