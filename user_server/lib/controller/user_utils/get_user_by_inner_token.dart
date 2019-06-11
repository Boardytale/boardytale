part of user_utils;

Future<shelf.Response> getUserByInnerToken(String innerToken, ManagedContext context, core.ToUserServerMessage message) async {
  var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.getUser.innerToken);
  User user = await query.fetchOne();
  if (user != null) {
    core.User coreUser = core.User.fromJson(user.asMap());
    coreUser.hasHero = (await getFirstHero(user.id, context)) != null;
  message.addUser(coreUser);
  }
  return shelf.Response.ok(json.encode(message.toJson()));
}
