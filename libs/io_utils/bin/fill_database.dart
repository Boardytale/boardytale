import "dart:io";
import 'dart:math';
import 'dart:convert';
import 'package:core/model/model.dart' as model;
import 'package:io_utils/io_utils.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:core/configuration/configuration.dart';

String projectDirectoryPath = getProjectDirectory().path;

main() async {
  await createImages();
  await createUnits();
  await createTale();
}

createUnits() async {
  List<FileSystemEntity> entities = Directory(projectDirectoryPath + "/data/units").listSync(recursive: true);
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();

  for (FileSystemEntity entity in entities) {
    if (entity is File) {
      if (path.extension(entity.path) == ".json") {
        String url = makeAddressFromUri(boardytaleConfiguration.editorServer.uris.first) + "units";
        print("uploading unit" + entity.path + " to url: $url");
        http.Response response =
            await http.post(url, headers: {"Content-Type": "application/json"}, body: entity.readAsStringSync());
        print(
            "uploaded unit ${entity.path}: ${response.statusCode} ${response.body.substring(0, min(response.body.length, 300))}");

        response = await http.post(url + "/compile",
            headers: {"Content-Type": "application/json"},
            body: json
                .encode({"id": model.UnitTypeCreateEnvelope.fromJson(json.decode(entity.readAsStringSync())).name}));
        print(
            "compiled unit: ${entity.path}: ${response.statusCode} ${response.body.substring(0, min(response.body.length, 300))}");
        entity.delete();
      }
    }
  }
}

createImages() async {
  List<FileSystemEntity> entities =
      Directory(projectDirectoryPath + "/data/images").listSync(recursive: true);
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();

  for (FileSystemEntity entity in entities) {
    if (entity is File) {
      if (path.extension(entity.path) == ".json") {
        String url = makeAddressFromUri(boardytaleConfiguration.editorServer.uris.first) + "images";
        print("uploading image" + entity.path + " to url: $url");
        http.Response response =
            await http.post(url, headers: {"Content-Type": "application/json"}, body: entity.readAsStringSync());
        print(
            "uploaded image ${entity.path}: ${response.statusCode} ${response.body.substring(0, min(response.body.length, 300))}");
        entity.delete();
      }
    }
  }
}

createTale() async {
  List<FileSystemEntity> entities = Directory(projectDirectoryPath + "/data/tales").listSync(recursive: true);
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();

  for (FileSystemEntity entity in entities) {
    if (entity is File) {
      if (path.extension(entity.path) == ".json" && !entity.path.contains("compiled")) {
        String url = makeAddressFromUri(boardytaleConfiguration.editorServer.uris.first) + "tales";
        print("uploading tale" + entity.path + " to url: $url");
        http.Response response =
            await http.post(url, headers: {"Content-Type": "application/json"}, body: entity.readAsStringSync());
        print(
            "uploaded tale ${entity.path}: ${response.statusCode} ${response.body.substring(0, min(response.body.length, 300))}");

        print("compile tale ${url + "/compile"}");
        response = await http.post(url + "/compile",
            headers: {"Content-Type": "application/json"},
            body: json
                .encode({"id": model.TaleCreateEnvelope.fromJson(json.decode(entity.readAsStringSync())).tale.name}));
        print(
            "compiled tale: ${entity.path}: ${response.statusCode} ${response.body.substring(0, min(response.body.length, 300))}");
        entity.delete();
      }
    }
  }
}
