import 'dart:async';

import 'package:io_utils/aqueduct/wraps.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/model/user.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class RenameUserController extends ResourceController {
  RenameUserController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> renameUser(@Bind.body() RenameWrap renameWrapper) async {
    var query = Query<User>(context)..where((u) => u.innerToken).equalTo(renameWrapper.innerToken);
    User user = await query.fetchOne();
    if (user == null) {
      return Response.notFound();
    } else {
      query.values.name = renameWrapper.name;
      try{
        await query.update();
        return Response.ok(user.asMap());
      }catch(e){
        return Response.serverError(body: "Unable to rename, name is used");
      }
    }
  }
}
