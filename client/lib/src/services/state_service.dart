library state_service;

import 'dart:html';
import 'package:angular/core.dart';
import 'package:boardytale_client/src/services/settings_service.dart';
import 'package:boardytale_client/src/world/model/instance_generator.dart';
import 'package:boardytale_client/src/world/model/model.dart';
import 'package:utils/utils.dart';
import 'package:tales_compiler/tales_compiler.dart';

@Injectable()
class StateService {
  Notificator onTaleLoaded = new Notificator();
  Notificator onWorldLoaded = new Notificator();
  ClientTale tale;
  SettingsService settings;
  ValueNotificator<Map> onAlert = new ValueNotificator<Map>();

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

  void alertError(String text) {
    onAlert.notify({"text": text, "type": "error"});
  }

  void alertWarning(String text) {
    onAlert.notify({"text": text, "type": "warning"});
  }

  void alertNote(String text) {
    onAlert.notify({"text": text, "type": "note"});
  }
}
