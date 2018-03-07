import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart' as route;
import 'package:shelf_web_socket/shelf_web_socket.dart' as sWs;
import 'package:shelf_auth/shelf_auth.dart' as sAuth;
import 'package:shelf_exception_response/exception_response.dart';
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;
import 'package:web_socket_channel/web_socket_channel.dart';

Map<String, WebSocketChannel> connections = {};

void main(List<String> arguments) {
//  var authMiddleware = sAuth.authenticate(
//      [new MyAuthenticator()],
//      sessionHandler: new sAuth.JwtSessionHandler('bla', 'blub', new UserLookup()),
//      allowHttp: true,
//      allowAnonymousAccess: false);

  var router =
      (route.router()..get('/tales/{index}', _sendTale)..get('/ws', sWs.webSocketHandler(_handleWebSocketConnect)));

  var handler = const shelf.Pipeline()
      .addMiddleware(exceptionResponse())
      .addMiddleware(shelf.logRequests())
      .addMiddleware(shelf_cors.createCorsHeadersMiddleware())
//      .addMiddleware(authMiddleware)
      .addHandler(router.handler);

//  route.printRoutes(router);

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
    // TODO: copy tale assets to webserver - it is silly to decode and encode (AQUEDUCT should make something with this)
    return new shelf.Response.ok(output); //..contentType = ContentType.JSON;
  } else {
    return new shelf.Response.notFound(null);
  }
}

void _handleWebSocketConnect(WebSocketChannel channel) {
  String connectionName = "Socket: ${channel.hashCode}";
  connections[connectionName] = channel;
  channel.sink.add(JSON.encode({"name": connectionName}));
  updateOthers();
  channel.stream.listen((message) {
    channel.sink.add(message);
  }, onDone: () {
    connections.remove(connectionName);
    updateOthers();
  }, onError: () {
    connections.remove(connectionName);
    updateOthers();
  });
}

void updateOthers() {
  var socketMessage = JSON.encode({"sockets": connections.keys.toList(growable: false)});
  for (WebSocketChannel c in connections.values) {
    c.sink.add(socketMessage);
  }
}
