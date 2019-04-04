import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:editor_server/channel.dart';
import 'package:editor_server/model/tale.dart';

class LobbyDataController extends ResourceController {
  LobbyDataController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getLobbyList() async {
    List lobbyTales;
    Function process;
    var catchAttempts = 0;
    process = () async {
      try {
        var query = Query<Tale>(context)
          ..returningProperties((tale) => [tale.id, tale.lobbyTale])
          ..where((tale) => tale.compiled).equalTo(true);
        List<Tale> result = await query.fetch();
        lobbyTales = result.map((tale) => tale.lobbyTale.data).toList();
      } catch (e) {
        if(catchAttempts++ <3){
          await context.close();
          context = generateContext();
          await process();
        }
      }
    };
    await process();
    return Response.ok(lobbyTales);
  }
}
