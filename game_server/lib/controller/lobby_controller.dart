import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:io_utils/aqueduct/id_wrap.dart';

class LobbyController extends ResourceController {
  LobbyController ();

  @Operation.post()
  Future<Response> createLobby(@Bind.body() IdWrap idWrap) async {
    // TODO: return lobby list
    return Response.ok({});
  }
}
