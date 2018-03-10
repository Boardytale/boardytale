library boardytale.server;

import 'dart:convert';
import 'dart:io';
import 'package:boardytale_commons/model/model.dart';
import 'package:io_utils/io_utils.dart';
import 'package:tales_compiler/tales_compiler.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart' as route;
import 'package:shelf_web_socket/shelf_web_socket.dart' as sWs;
import 'package:shelf_auth/shelf_auth.dart' as sAuth;
import 'package:shelf_exception_response/exception_response.dart';
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;
import 'package:web_socket_channel/web_socket_channel.dart';

part 'connection.dart';
part 'connection_list.dart';

ConnectionList connections = new ConnectionList();
String pathToData = "../data";

void main(List<String> arguments) {
  Map<String, dynamic> fileMap = getFileMap(new Directory(pathToData));
  Map<String, Tale> tales = getTalesFromFileMap(fileMap);

  tales.forEach((k, v) {
    new File("web/tales/${v.id}.json").writeAsStringSync(JSON.encode(TaleAssetsPack.pack(v)));
  });
//  var authMiddleware = sAuth.authenticate(
//      [new MyAuthenticator()],
//      sessionHandler: new sAuth.JwtSessionHandler('bla', 'blub', new UserLookup()),
//      allowHttp: true,
//      allowAnonymousAccess: false);

  var router = (route.router()
    ..get('/tales/{index}', _sendTale)
    ..get('/ws', sWs.webSocketHandler((WebSocketChannel channel) => new Connection(channel))));

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
    return new shelf.Response.ok(output); //..contentType = ContentType.JSON;
  } else {
    return new shelf.Response.notFound(null);
  }
}
