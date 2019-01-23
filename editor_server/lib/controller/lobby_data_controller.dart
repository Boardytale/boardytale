import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class LobbyDataController extends ResourceController {
  LobbyDataController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getLobbyList() async {
    // TODO: return lobby list
    return Response.ok({});
  }
}
