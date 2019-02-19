part of io_utils;

BoardytaleConfiguration getConfiguration() {
  try {
    return BoardytaleConfiguration.fromJson(convert.json.decode(
        File(getProjectDirectory().path + '/config.json').readAsStringSync()));
  } catch (e) {
    if (e is CheckedFromJsonException) {
      print(e.innerError.toString());
    }
    throw e;
  }
}
