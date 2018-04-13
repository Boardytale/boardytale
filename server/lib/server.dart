library boardytale.server;

import 'dart:io';
import 'package:boardytale_server/services/connection_handler.dart';
import 'package:boardytale_server/services/game.dart';
import 'package:boardytale_server/services/tale_filer.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart' as route;
import 'package:shelf_web_socket/shelf_web_socket.dart' as sWs;
import 'package:shelf_exception_response/exception_response.dart';
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;

ConnectionHandler connectionHandler = new ConnectionHandler();
String pathToData = "../data";

void main(List<String> arguments) {
  compileTales();
  // TODO: transform to array with a lookup
  Game currentGame = new Game("bandits");
//  Game currentGame = new Game("1vs1");
  connectionHandler.currentGame = currentGame;
//  var authMiddleware = sAuth.authenticate(
//      [new MyAuthenticator()],
//      sessionHandler: new sAuth.JwtSessionHandler('bla', 'blub', new UserLookup()),
//      allowHttp: true,
//      allowAnonymousAccess: false);

  var router = route.router()
    ..get('/tales/{index}', _sendTale)
    ..get('/ws', sWs.webSocketHandler(connectionHandler.handleConnection));

  var handler = const shelf.Pipeline()
      .addMiddleware(exceptionResponse())
      .addMiddleware(shelf.logRequests())
  // web socket bridge is on another port than rest of application
  // it probably better solution, you can test new front-end on live api
      .addMiddleware(shelf_cors.createCorsHeadersMiddleware())
//      .addMiddleware(authMiddleware)
      .addHandler(router.handler);

//  route.printRoutes(router);

  // TODO: refactor port number to args
  io.serve(handler, '127.0.0.1', 8086).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}

shelf.Response _sendTale(shelf.Request request) {
  String index = route.getPathParameter(request, "index");
  String path = "web/tales/$index.json";
  File tale = new File(path);
  if (tale.existsSync()) {
    String output = tale.readAsStringSync();
    return new shelf.Response.ok(output); //..contentType = ContentType.JSON;
  } else {
    return new shelf.Response.notFound(null);
  }
}
