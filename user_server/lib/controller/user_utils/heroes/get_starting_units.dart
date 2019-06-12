part of user_utils;

Future<shelf.Response> getStartingUnits(
    String userEmail, String heroId, ManagedContext context, core.ToUserServerMessage message) async {
  var query = Query<User>(context)..where((u) => u.email).equalTo(userEmail);
  User user = await query.fetchOne();
  if (user != null) {
    int heroIdInt;
    if(heroId != null){
      heroIdInt = int.tryParse(heroId);
    }
    Hero hero;
    if (heroIdInt != null) {
      var heroesQuery = Query<Hero>(context)
        ..where((hero) => hero.user.id).equalTo(user.id)
        ..where((hero) => hero.heroId).equalTo(heroIdInt);
      hero = await heroesQuery.fetchOne();
    }
    if(hero == null) {
      var heroesQuery = Query<Hero>(context)
        ..where((hero) => hero.user.id).equalTo(user.id);
      hero = await heroesQuery.fetchOne();
    }
    if(hero == null){
      return shelf.Response.notFound("hero ${heroId} for player ${userEmail} not found");
    }
    core.GameHeroEnvelope envelope;
    try{
      envelope = core.GameHeroEnvelope.fromJson(hero.heroData.data as Map<String, dynamic>);
    }catch(e){
      return shelf.Response.notFound("bad format of hero ${heroId} for player ${userEmail}");
    }

    message.addHeroesAndUnitsToStartingUnits([envelope], []);
    return shelf.Response.ok(json.encode(message.toJson()));
  }
  return shelf.Response.notFound("user not filled in starting unit request");
}
