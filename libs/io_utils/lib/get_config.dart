part of io_utils;

BoardytaleConfiguration getConfiguration({bool production = false}) {
  try {
    if (production) {
      return BoardytaleConfiguration.fromJson(convert.json
          .decode(File(getProjectDirectory().path + '/../boardytale_production_config/config.g.json').readAsStringSync()));
    } else {
      return BoardytaleConfiguration.fromJson(
          convert.json.decode(File(getProjectDirectory().path + '/config.g.json').readAsStringSync()));
    }
  } catch (e) {
    if (e is CheckedFromJsonException) {
      print(e.innerError.toString());
    }
    throw e;
  }
}
