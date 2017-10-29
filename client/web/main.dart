import 'dart:html';

import 'package:boardytale_client/app_component.dart';
import 'package:angular/angular.dart';

void main() {
  bootstrap(AppComponent);
  HttpRequest.getString("http://localhost:8086/questions").then((string){
    print(string);
  });
}
