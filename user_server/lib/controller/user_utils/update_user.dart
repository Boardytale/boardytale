part of user_utils;

// TODO: rethink security - innerToken is silver bullet to find user. It may by harder to hack if innerToken is stolen. Check also email?

Future<Response> updateUser(core.ToUserServerMessage message, ManagedContext context) async {
  core.User coreUser = message.getUpdateUser;
  var query = Query<User>(context)..where((u) => u.innerToken).equalTo(coreUser.innerToken);
  if (coreUser.email != null) {
    query.values.email = coreUser.email;
  }
  if (coreUser.name != null) {
    query.values.name = coreUser.name;
  }
  try {
    await query.update();
    return Response.ok(message.toJson());
  } catch (e) {
    return Response.forbidden(body: "Unable to update user, name or email is used");
  }
}
