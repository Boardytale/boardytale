import 'dart:async';
import 'dart:convert';
import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/model/user.dart';
import 'package:core/configuration/configuration.dart';
import 'package:core/model/model.dart' as core;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

class UserInnerAuthController extends ResourceController {
  UserInnerAuthController(this.context, this.config) {
    run();
  }
  final BoardytaleConfiguration config;

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
    if (message.message == core.OnUserServerAction.getUseresByInnerToken) {
      var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.getUser.innerToken);
      List<User> users = await query.fetch();
      if (users.isNotEmpty) {
        message.addUser(core.User.fromJson(users.first.asMap()));
      }
      return shelf.Response.ok(json.encode(message.toJson()));
    }
    return shelf.Response.notFound(json.encode({"error": "${message.message} is not known message"}));
  }
}
