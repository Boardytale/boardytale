import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/model/user.dart';
import 'package:io_utils/aqueduct/wraps.dart';

class UserInnerAuthController extends ResourceController {
  UserInnerAuthController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> getUserByInnerToken(
      @Bind.body() InnerTokenWrap innerTokenWrap) async {
    var query = Query<User>(context)
      ..where((u) => u.innerToken).equalTo(innerTokenWrap.innerToken);
    List<User> users = await query.fetch();
    if (users.isEmpty) {
      return Response.notFound();
    } else {
      return Response.ok(users.first.asMap());
    }
  }
}
