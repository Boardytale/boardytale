part of user_utils;

Future<shelf.Response> setAfterGameGain(core.ToUserServerMessage message, ManagedContext context) async {
  core.HeroAfterGameGain gain = message.getHeroAfterGameGain;
  if(gain.heroId == null){
    return shelf.Response.forbidden("gain heroId have to be set");
  }
  int heroIdInt = int.tryParse(gain.heroId);
  if(heroIdInt == null){
    return shelf.Response.forbidden("gain heroId is in bad format ${gain.heroId}");
  }

  var heroesQuery = Query<Hero>(context)..where((hero) => hero.heroId).equalTo(heroIdInt);

  HeroAfterGameGain newGain = HeroAfterGameGain()
    ..hero = await heroesQuery.fetchOne()
    ..dataFormatVersion = 0
    ..gainData = Document(gain.toJson());
  newGain = await (Query<HeroAfterGameGain>(context)..values = newGain).insert();

  return shelf.Response.ok(json.encode(message.toJson()));
}
