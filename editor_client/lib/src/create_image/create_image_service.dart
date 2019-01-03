import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:angular/core.dart';
import 'package:shared/configuration/configuration.dart';

@Injectable()
class CreateImageService {
  final http.Client _http;

  CreateImageService(this._http){

  }

  void addImage(String image) {
    this._http.post("/editorApi/images/add");
  }
}
