import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:core/configuration/configuration.dart';
import 'package:io_utils/aqueduct/wraps.dart';
import 'package:io_utils/io_utils.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:core/model/model.dart' as core;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

String projectDirectoryPath = getProjectDirectory().path;
Process tsProcess;
int tsPort = 15000 + math.Random().nextInt(10000);

void main() {
  final BoardytaleConfiguration config = getConfiguration();
  MockedEditor editor = MockedEditor(config);
}

class MockedEditor {
  MockedEditor(this.config) {
    run();
  }

  final BoardytaleConfiguration config;
  int counter = 0;

  Map<String, Completer> stdoutCompleters = {};

  void run() async {
    var handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(_echoRequest);

    var server = await io.serve(handler, 'localhost', config.editorServer.uris.first.port.toInt());

    // Enable content compression
    server.autoCompress = true;

    print('Serving mocked editor at http://${server.address.host}:${server.port}');

    tsProcess = await Process.start("npm", ["run", "ts-node", "libs/generate-data-json-service.ts", "$tsPort"],
        workingDirectory: projectDirectoryPath, runInShell: true);
    printFromOutputStreams(tsProcess, "ts:", "blue");
//    await Future.delayed(Duration(seconds: 1));
//    List lobbies = await getLobbies();
//    print("got lobbies ${lobbies}");

  }

  Future<String> getFileByPath(String path) async{
    String harmonizedPath = path.replaceAll("\\", "/");
    var url = "http://localhost:${tsPort}/";
    print("sent?  ${harmonizedPath}");
    http.Response response = await http.post(url, body: harmonizedPath);
    print("got?  ${response.body}");
    return response.body;
  }

  Future<shelf.Response> _echoRequest(shelf.Request request) async {
    if (request.url.path == "inner/lobbyList") {
      String out = json.encode(await getLobbies());
      return shelf.Response.ok(out);
    } else {
      String body = await request.readAsString();
      String id = (IdWrap()..readFromMap(json.decode(body) as Map<String, dynamic>)).id;
      String out = json.encode(await getCompiledTale(id));
      return shelf.Response.ok(out);
    }
  }

  Future<List> getLobbies() async {
    List<FileSystemEntity> entities =
        Directory("${projectDirectoryPath}/core/lib/data/tales").listSync(recursive: true);
    List out = [];
    for (FileSystemEntity entity in entities) {
      if (entity is File) {
        if (path.extension(entity.path) == ".ts") {
          String outString = await getFileByPath(entity.path);
          try {
            print("success ${entity.path}");
            core.TaleCompiled tale = core.TaleCompiled.fromJson(json.decode(outString) as Map<String, dynamic>);
            File imageFile = File("${projectDirectoryPath}/core/lib/data/image_sources/${tale.lobby.image.data}");
            List<int> imageBytes = imageFile.readAsBytesSync();
            tale.lobby.image.data = "data:image/${path.extension(imageFile.path).replaceAll(".", "")};base64,${base64Encode(imageBytes)}";
            out.add(tale.lobby.toJson());
          } catch (e) {
            print("fail ${entity.path}");
          }
        }
      }
    }
    return out;
  }

  Future<core.TaleCompiled> getCompiledTale(String name) async {
    core.TaleCreateEnvelope tale = await getTaleByName(name);
    Set<String> unitTypeNeededNames = Set();
    var taleInnerDataEnvelope = tale.tale;
    core.TaleCompiled taleCompiled = core.TaleCompiled();
    taleCompiled.tale = core.TaleInnerCompiled.fromJson(taleInnerDataEnvelope.toJson());
    taleCompiled.lobby = tale.lobby;

    core.TaleInnerCompiled innerCompiled = taleCompiled.tale;

    innerCompiled.images = {};
    innerCompiled.unitTypes = {};

    for (var envelope in innerCompiled.units) {
      unitTypeNeededNames.add(envelope.changeToTypeName);
    }
    innerCompiled.unitTypes = await getUnitTypesCompiled(unitTypeNeededNames);
    return taleCompiled;
  }

  Future<Map<String, core.UnitTypeCompiled>> getUnitTypesCompiled(Set<String> unitTypeNeededNames) async {
    Stopwatch stopwatch = Stopwatch()..start();
    List<FileSystemEntity> entities =
        Directory("${projectDirectoryPath}/core/lib/data/units").listSync(recursive: true);
    Map<String, core.UnitTypeCreateEnvelope> envelopes = {};
    Set<String> imageNames = Set();

    Future getType(String path) async {
      String outString = await getFileByPath(path);
      try {
        print("success ${path}");
        core.UnitTypeCreateEnvelope unitEnvelope =
            core.UnitTypeCreateEnvelope.fromJson(json.decode(outString) as Map<String, dynamic>);
        if (unitTypeNeededNames.contains(unitEnvelope.name)) {
          envelopes[unitEnvelope.name] = unitEnvelope;
          imageNames.add(unitEnvelope.bigImageName);
          imageNames.add(unitEnvelope.imageName);
          imageNames.add(unitEnvelope.iconName);
        }
      } catch (e) {
        print("fail ${path}");
      }
    }

    List<Future> callbacks = [];
    for (FileSystemEntity entity in entities) {
      if (entity is File) {
        if (unitTypeNeededNames.any((name) => entity.path.contains(name)) && path.extension(entity.path) == ".ts") {
          callbacks.add(getType(entity.path));
        }
      }
    }
    await Future.wait(callbacks);
    Map<String, core.Image> images = await getImagesByNames(imageNames..removeWhere((name) => name == null));
    Map<String, core.UnitTypeCompiled> out = {};
    envelopes.forEach((key, envelope) {
      out[key] = core.UnitTypeCompiled.fromJson(envelope.toJson())
        ..bigImage = images[envelope.bigImageName]
        ..image = images[envelope.imageName]
        ..icon = images[envelope.iconName];
    });
    print("unit types: ${stopwatch.elapsed.inMilliseconds}");
    return out;
  }

  Future<Map<String, core.Image>> getImagesByNames(Set<String> names) async {
    List<FileSystemEntity> entities =
        Directory("${projectDirectoryPath}/core/lib/data/images").listSync(recursive: true);
    Stopwatch stopwatch = Stopwatch()..start();
    Map<String, core.Image> images = {};

    Future getImage(FileSystemEntity entity) async {
      String outString = await getFileByPath(entity.path);
      try {
        print("success ${entity.path}");
        core.Image image = core.Image.fromJson(json.decode(outString) as Map<String, dynamic>);
        if (names.contains(image.name)) {
          File imageFile = File("${projectDirectoryPath}/core/lib/data/image_sources/${image.data}");
          List<int> imageBytes = imageFile.readAsBytesSync();
          image.data = "data:image/${path.extension(imageFile.path)};base64,${base64Encode(imageBytes)}";
          images[image.name] = image;
        }
      } catch (e) {
        print("fail ${entity.path}");
      }
    }

    List<Future> callbacks = [];
    for (FileSystemEntity entity in entities) {
      if (entity is File) {
        if (names.any((name) => entity.path.contains(name)) && path.extension(entity.path) == ".ts") {
          callbacks.add(getImage(entity));
        }
      }
    }
    await Future.wait(callbacks);
    print("images: ${stopwatch.elapsed.inMilliseconds}");
    return images;
  }

  Future<core.TaleCreateEnvelope> getTaleByName(String name) async {
    List<FileSystemEntity> entities =
        Directory("${projectDirectoryPath}/core/lib/data/tales").listSync(recursive: true);
    for (FileSystemEntity entity in entities) {
      if (entity is File) {
        if (entity.path.contains(name) && path.extension(entity.path) == ".ts") {
          String outString = await getFileByPath(entity.path);
          try {
            print("success ${entity.path}");
            core.TaleCreateEnvelope tale =
                core.TaleCreateEnvelope.fromJson(json.decode(outString) as Map<String, dynamic>);
            if (tale.tale.name == name) {
              File imageFile = File("${projectDirectoryPath}/core/lib/data/image_sources/${tale.lobby.image.data}");
              List<int> imageBytes = imageFile.readAsBytesSync();
              tale.lobby.image.data = "data:image/${path.extension(imageFile.path).replaceAll(".", "")};base64,${base64Encode(imageBytes)}";
              return tale;
            }
          } catch (e) {
            print("fail ${entity.path}");
          }
        }
      }
    }
    return null;
  }
}
