import 'package:http/http.dart' as http;

main() {
 http.get("http://localhost:4201").then((data){
   print(data.body);
 });
}
