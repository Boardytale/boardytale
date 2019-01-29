import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:editor_server/model/tale.dart';

class LobbyDataController extends ResourceController {
  LobbyDataController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getLobbyList() async {
    var query = Query<Tale>(context)
      ..returningProperties((tale) => [tale.id, tale.lobbyTale]);
    List<Tale> result = await query.fetch();
    List lobbyTales = result.map((tale) => tale.lobbyTale.data).toList();
    return Response.ok(lobbyTales);
  }
}
