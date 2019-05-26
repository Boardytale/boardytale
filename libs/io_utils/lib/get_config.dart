part of io_utils;

BoardytaleConfiguration getConfiguration({bool production = false}) {
//  try {
    if (production) {
      return BoardytaleConfiguration.fromJson(convert.json
          .decode(File(getProjectDirectory().path + '/../boardytale_production_config/config.g.json').readAsStringSync()));
    } else {
      var decoded = convert.json.decode(File(getProjectDirectory().path + '/config.g.json').readAsStringSync());
      return BoardytaleConfiguration.fromJson(decoded);
    }
//  } catch (e) {
//    if (e is CheckedFromJsonException) {
//      print(e.innerError.toString());
//    }
//    throw e;
//  }
}
