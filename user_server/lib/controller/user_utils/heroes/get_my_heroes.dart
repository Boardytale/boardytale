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

