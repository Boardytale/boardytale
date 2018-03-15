library state_service;

import 'dart:html';
import 'package:angular/core.dart';
import 'package:boardytale_client/services/settings_service.dart';
import 'package:boardytale_client/world/model/instance_generator.dart';
import 'package:boardytale_client/world/model/model.dart';
import 'package:utils/utils.dart';
import 'package:tales_compiler/tales_compiler.dart';

@Injectable()
class StateService {
  Notificator onTaleLoaded = new Notificator();
  Notificator onWorldLoaded = new Notificator();
  ClientTale tale;
  SettingsService settings;

  StateService(this.settings);
  void loadTale(String taleId) {
    HttpRequest.getString("http://localhost:8086/tales/$taleId").then(loadTaleFromData);
  }

  void loadTaleFromData(String source) {
    Map data = parseJsonMap(source);
    tale = TaleAssetsPack.unpack(data, new ClientInstanceGenerator());
    (tale.world as ClientWorld).init(this, settings);
    onTaleLoaded.notify();
  }
}
