import 'dart:async';

import 'package:io_utils/aqueduct/wraps.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/model/user.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class TemporaryUserController extends ResourceController {
  TemporaryUserController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> createTemporaryUser(@Bind.body() NameWrap nameWrapper) async {
    User newUser = User()
      ..email = "${uuid.v4().toString()}@temp.com"
      ..innerToken = uuid.v4().toString() + nameWrapper.name;
    newUser = await (Query<User>(context)..values = newUser).insert();
    return Response.ok(newUser.asMap());
  }
}
