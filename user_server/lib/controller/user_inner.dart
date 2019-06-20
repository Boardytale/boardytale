import 'dart:async';
import 'dart:convert';
import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/controller/user_utils/user_utils.dart';
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
    core.ToUserServerInnerMessage message = core.ToUserServerInnerMessage.fromJson(json.decode(body) as Map<String, dynamic>);
    if (message.message == core.OnUserServerInnerAction.getUserByInnerToken) {
      return getUserByInnerToken(message.getUser.innerToken, context, message);
    }
    if (message.message == core.OnUserServerInnerAction.getStartingUnits) {
      return getStartingUnits(message.getStartingUnits.requestedPlayerEmail, message.getStartingUnits.requestedHeroId, context, message);
    }
    if(message.message == core.OnUserServerInnerAction.setHeroAfterGameGain){
      return setAfterGameGain(message, context);
    }
    return shelf.Response.notFound(json.encode({"error": "${message.message} is not known message"}));
  }

}
