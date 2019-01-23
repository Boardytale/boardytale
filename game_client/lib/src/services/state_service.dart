library state_service;

import 'dart:async';
import 'package:angular/core.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:game_client/src/world/model/model.dart';

@Injectable()
class StateService {
//  Notificator onTaleLoaded = new Notificator();
  Stream get onWorldLoaded => _onWorldLoaded.stream;
  StreamController _onWorldLoaded = new StreamController();
  ClientTale tale;
  int teamPlaying = 1;
  SettingsService settings;
  StreamController<Map> _onAlert = new StreamController<Map>();

  Stream<Map> get onAlert => _onAlert.stream;

  StateService(this.settings);

  void worldIsLoaded() {
    this._onWorldLoaded.add(null);
  }

//  void loadTale(String taleId) {
//    HttpRequest.getString("http://localhost:8086/tales/$taleId").then(loadTaleFromData);
//  }
//
//  void loadTaleFromData(String source) {
//    Map data = parseJsonMap(source);
//    tale = TaleAssetsPack.unpack(data, new ClientInstanceGenerator());
//    (tale.world as ClientWorld).init(this, settings);
//    onTaleLoaded.notify();
//  }
//
  void alertError(String text) {
    _onAlert.add({"text": text, "type": "error"});
  }

  void alertWarning(String text) {
    _onAlert.add({"text": text, "type": "warning"});
  }

  void alertNote(String text) {
    _onAlert.add({"text": text, "type": "note"});
  }
}
