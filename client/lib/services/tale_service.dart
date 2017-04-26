library tale_service;

import 'dart:convert';
import 'dart:html';
import 'package:angular2/core.dart';
import 'package:utils/utils.dart';
import 'package:boardytale_commons/model/model.dart';
import 'package:tales_compiler/tales_compiler.dart';



@Injectable()
class TaleService{
  Notificator onTaleLoaded = new Notificator();
  Tale tale;

  TaleService(){
    HttpRequest.getString("http://localhost:8086/tales/0").then((String s) {
      Map data = JSON.decode(s);
      tale = TaleAssetsPack.unpack(data);
      onTaleLoaded.notify();
    });
  }

}