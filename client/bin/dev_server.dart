import 'package:pub_serve_rewrites/rewrites.dart';

main(){
  server(port: 8085)
    ..ignoreAll([
      r'^(\S+\.(json|html|js|dart|css|png))$',
    ])
    ..rewrite('/admin/(.*)',to:'admin.html')
    ..ignore('/tales/(.*)')
    ..ignore('/img/(.*)')
    ..rewrite(r'(.*)',to:'/index.html')
    ..start('http://localhost:8082');
}