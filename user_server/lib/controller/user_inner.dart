import 'dart:async';
import 'dart:convert';
import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/controller/user_utils/user_utils.dart';
import 'package:user_server/model/db_objects.dart';
import 'package:core/configuration/configuration.dart';
import 'package:core/model/model.dart' as core;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

class UserInnerController extends ResourceController {
  UserInnerController(this.context, this.config) {
    run();
  }

  final BoardytaleConfiguration config;
  int counter = 0;
  final ManagedContext context;

  void run() async {
    var handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(_echoRequest);
    var server = await io.serve(handler, 'localhost', config.userServer.innerPort);

    // Enable content compression
    server.autoCompress = true;

    print('Serving user server inner at http://${server.address.host}:${server.port}');
  }

  Future<shelf.Response> _echoRequest(shelf.Request request) async {
    String body = await request.readAsString();
    core.ToUserServerMessage message = core.ToUserServerMessage.fromJson(json.decode(body) as Map<String, dynamic>);
    if (message.message == core.OnUserServerAction.getUserByInnerToken) {
      var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.getUser.innerToken);
      User user = await query.fetchOne();
      if (user != null) {
        core.User coreUser = core.User.fromJson(user.asMap());
        coreUser.hasHero = (await getFirstHero(user.id, context)) != null;
        message.addUser(coreUser);
      }
      return shelf.Response.ok(json.encode(message.toJson()));
    }
    if (message.message == core.OnUserServerAction.getStartingUnits) {

      return getStartingUnits(message.getStartingUnits.requestedPlayerEmail, message.getStartingUnits.requestedHeroId, context);
//      //      core.GetHeroesOfPlayer heroes = message.getHeroesOfPlayerMessage;
//      //      message.addHeroesAndUnits([mockedHeroes[3]], [pikeman]);
//      message.addHeroesAndUnits([heroesData[counter]], [pikeman]);
//      counter++;
//      if (counter >= heroesData.length) {
//        counter = 0;
//      }
//      return shelf.Response.ok(json.encode(message.toJson()));
    }
    return shelf.Response.notFound(json.encode({"error": "${message.message} is not known message"}));
  }

}
