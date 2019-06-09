part of user_utils;

Future<Hero> getFirstHero(int userId, ManagedContext context) {
  var heroesQuery = Query<Hero>(context)..where((hero) => hero.user.id).equalTo(userId);
  return heroesQuery.fetchOne();
}
