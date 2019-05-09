library hero_server;

import 'package:core/configuration/configuration.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'dart:async';
import 'package:core/model/model.dart' as core;
import 'dart:convert';

part "src/mocked_heroes.dart";

class HeroServer {
  final BoardytaleConfiguration config;
  int counter = 0;
  HeroServer(this.config) {
    run();
  }

  void run() async {
    var handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(_echoRequest);

    var server = await io.serve(handler, 'localhost', config.heroesServer.uris.first.port);

    // Enable content compression
    server.autoCompress = true;

    print('Serving at http://${server.address.host}:${server.port}');
  }

  Future<shelf.Response> _echoRequest(shelf.Request request) async {
    String body = await request.readAsString();
    core.ToHeroServerMessage message = core.ToHeroServerMessage.fromJson(json.decode(body));
    if (message.message == core.OnHeroServerAction.getHeroesOfPlayer) {
//      core.GetHeroesOfPlayer heroes = message.getHeroesOfPlayerMessage;
      message.addHeroes([mockedHeroes[2]]);
      counter++;
      if (counter >= mockedHeroes.length) {
        counter = 0;
      }
      return shelf.Response.ok(json.encode(message.toJson()));
    }
    return shelf.Response.notFound('Request for "${request.url}"');
  }
}
