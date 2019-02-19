//import 'package:pub_serve_rewrites/rewrites.dart';
//
//void main() {
//  server(port: 8080)
//    ..ignoreAll([
//      r'^(\S+\.(json|html|js|dart|css|png))$',
//    ])
//    ..rewrite('/admin/(.*)', to: 'admin.html')
//    ..ignore('/tales/(.*)')
//    ..ignore('/img/(.*)')
//    ..ignore(r'(.map)')
//    ..rewrite(r'(.*)', to: '/index.html')
//    ..start('http://localhost:8085');
//}
