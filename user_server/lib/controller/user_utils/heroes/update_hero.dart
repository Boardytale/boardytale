part of user_utils;

Future<Response> updateHero(core.ToUserServerMessage message, ManagedContext context) async {
  core.HeroUpdate update = message.getHeroUpdate;

  int heroIdInt = int.tryParse(update.heroId ?? "");
  if (heroIdInt == null) {
    return Response.badRequest(body: "bad format of heroId");
  }

  var heroQuery = Query<Hero>(context)..where((hero) => hero.heroId).equalTo(heroIdInt);

  Hero hero = await heroQuery.fetchOne();
  if (hero != null) {
    var userQuery = Query<User>(context)..where((user) => user.id).equalTo(hero.user.id);
    User user = await userQuery.fetchOne();
    if (user != null) {
      if (user.innerToken != message.innerToken) {
        return Response.unauthorized(body: "bad innerToken");
      }
    } else {
      return Response.serverError(body: "user not found");
    }

    core.HeroEnvelope heroEnvelope = core.HeroEnvelope.fromJson(hero.heroData.data as Map<String, dynamic>);

    if (update.pickGainId != null) {
      var gainQuery = Query<HeroAfterGameGain>(context)..where((gain) => gain.gainId).equalTo(update.pickGainId);
      HeroAfterGameGain gain = await gainQuery.fetchOne();
      if (gain != null) {
        if (gain.hero.heroId != hero.heroId) {
          return Response.unauthorized(body: "This gain does not belong to you");
        }
        // hero is player's, player is authorized, gain belongs to hero
        core.HeroAfterGameGain coreGain = core.HeroAfterGameGain.fromJson(gain.gainData.data as Map<String, dynamic>);
        heroEnvelope.money += coreGain.money;
        heroEnvelope.experience += coreGain.xp;
        coreGain.itemIds.forEach((itemId){
          heroEnvelope.inventoryItems.add(itemsData[itemId]);
        });
      }else{
        return Response.notFound(body: "Gain was not found");
      }
      await gainQuery.delete();
    }

    core.Hero(heroEnvelope).updateType();
    heroQuery.values.heroData = Document(heroEnvelope.toJson());
    await heroQuery.updateOne();
    message.addHeroDetailToUpdate(heroEnvelope);

    return Response.ok(message.toJson());
  } else {
    return Response.badRequest(body: {"message": "bad inner token"});
  }
}
