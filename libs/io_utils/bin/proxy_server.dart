// Attempt to solve sse for dart webdev version 2+

//        import 'package:shelf/shelf_io.dart' as shelf_io;
//        import 'package:shelf/shelf.dart' as shelf;
//        import 'package:shelf_proxy/shelf_proxy.dart';
//
//        void main() {
//          Uri uri = Uri.parse("http://localhost:4201/");
//          shelf.Handler shelfProxyHandler = proxyHandler(uri);
//          String pathToRewrite = "game";
//          shelf_io.serve((serverRequest) {
//             var requestUrl = uri.resolve(serverRequest.url.toString());
//             if(requestUrl.pathSegments.isNotEmpty){
//               if(requestUrl.pathSegments.contains("\$sseHandler")){
//                  // We have really big issue here
//               }
//               if(requestUrl.pathSegments.first == pathToRewrite){
//                 return shelfProxyHandler(serverRequest.change(path: pathToRewrite));
//               }
//             }
//             return shelfProxyHandler(serverRequest);
//          }, 'localhost', 8090)
//              .then((server) {
//            print('Proxying at http://${server.address.host}:${server.port}');
//          });
//        }
