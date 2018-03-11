library state_service;

import 'dart:html';
import 'package:angular/core.dart';
import 'package:boardytale_client/services/settings_service.dart';
import 'package:boardytale_client/world/model/class_generator.dart';
import 'package:boardytale_client/world/model/model.dart';
import 'package:utils/utils.dart';
import 'package:tales_compiler/tales_compiler.dart';

@Injectable()
class StateService{
  Notificator onTaleLoaded = new Notificator();
  Notificator onWorldLoaded = new Notificator();
  ClientTale tale;
  ClientWorld world;
  SettingsService settings;

  StateService(this.settings);
  void loadTale(String taleId){
    HttpRequest.getString("http://localhost:8086/tales/$taleId").then((String s) {
      Map data = parseJsonMap(s);
      tale=new ClientTale();
      TaleAssetsPack.unpack(data, tale, new ClientClassGenerator());
      world=tale.map;
      world.init(this, settings);
      onTaleLoaded.notify();
    });
  }

}