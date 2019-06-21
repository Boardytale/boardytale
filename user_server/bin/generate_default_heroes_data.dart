import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:core/configuration/configuration.dart';
import 'package:io_utils/io_utils.dart';
import 'package:core/model/model.dart' as core;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

String projectDirectoryPath = getProjectDirectory().path;
Process tsProcess;
int tsPort = 15000 + math.Random().nextInt(10000);

void main() {
  final BoardytaleConfiguration boardytaleConfiguration = getConfiguration();
  MockedEditor(boardytaleConfiguration);
}

class MockedEditor {
  MockedEditor(this.config) {
    run();
  }

  final BoardytaleConfiguration config;
  int counter = 0;

  Map<String, Completer> stdoutCompleters = {};

  void run() async {
    tsProcess = await Process.start("npm", ["run", "ts-node", "libs/generate-data-json-service.ts", "$tsPort"],
        workingDirectory: projectDirectoryPath, runInShell: true);
    Stream<String> output = printFromOutputStreams(tsProcess, "ts:", "blue");
    output.listen((String data) {
      if (data.contains(":::running:::")) {
        generate();
      }
    });
  }

  void generate() async {
    Map<String, core.ItemEnvelope> items = await getItems();
    createEnvelopes(items);
    generateItems(items);
  }

  Future createEnvelopes(Map<String, core.ItemEnvelope> items) async {
    List<core.HeroEnvelope> heroEnvelopes = await getDefaultHeroes(items);
    String out = """
        part of heroes;
        // generated from data/default_heroes by user_server/bin/generate_default_heroes_data.dart
        List<core.HeroEnvelope> heroesData = [
        ${heroEnvelopes.map((envelope) {
      return "core.HeroEnvelope.fromJson(${json.encode(envelope.toJson())})";
    }).join(",\n")}
        ];
        """;
    File("${projectDirectoryPath}/user_server/lib/model/src/heroes_data.g.dart").writeAsStringSync(out);
    Process dartfmt = await Process.start(
        "dartfmt", ["-w", "${projectDirectoryPath}/user_server/lib/model/src/heroes_data.g.dart"],
        workingDirectory: projectDirectoryPath, runInShell: true);
    printFromOutputStreams(dartfmt, "dartfmt:", "blue");
  }

  Future generateItems(Map<String, core.ItemEnvelope> items) async {
    String out = """
        part of heroes;
        // generated from data/default_heroes by user_server/bin/generate_default_heroes_data.dart
        Map<String, core.ItemEnvelope> itemsData = {
        ${items.values.map((envelope) {
      return "\"${envelope.typeName}\": core.ItemEnvelope.fromJson(${json.encode(envelope.toJson())})";
    }).join(",\n")}
        };
        """;
    File("${projectDirectoryPath}/user_server/lib/model/src/items_data.g.dart").writeAsStringSync(out);
    Process dartfmt = await Process.start(
        "dartfmt", ["-w", "${projectDirectoryPath}/user_server/lib/model/src/items_data.g.dart"],
        workingDirectory: projectDirectoryPath, runInShell: true);
    printFromOutputStreams(dartfmt, "dartfmt:", "blue");
  }

  Future<String> getFileByPath(String path) async {
    String harmonizedPath = path.replaceAll("\\", "/");
    var url = "http://localhost:${tsPort}/";
    http.Response response = await http.post(url, body: harmonizedPath);
    return response.body;
  }

  Future<List<core.HeroEnvelope>> getDefaultHeroes(Map<String, core.ItemEnvelope> itemsData) async {
    List<FileSystemEntity> entities =
        Directory("${projectDirectoryPath}/data/default_heroes").listSync(recursive: true);
    List<core.HeroEnvelope> out = [];
    for (FileSystemEntity entity in entities) {
      if (entity is File) {
        if (path.extension(entity.path) == ".ts") {
          String outString = await getFileByPath(entity.path);
          try {
            print("success ${entity.path}");
            core.HeroEnvelope heroEnvelope = core.HeroEnvelope.fromJson(json.decode(outString) as Map<String, dynamic>);
            Map<core.ItemPosition, String> names = heroEnvelope.equippedItemNames;
            heroEnvelope.equippedItems = {};
            if (names != null) {
              names.forEach((key, id){
                heroEnvelope.equippedItems[key] =  itemsData[id];
              });
            }
            out.add(heroEnvelope);
          } catch (e) {
            print("fail ${entity.path} $e");
          }
        }
      }
    }
    return out;
  }

  Future<core.ItemEnvelope> getItemByName(String name) async {
    String outString = await getFileByPath("${projectDirectoryPath}/data/items/${name}.ts");
    try {
      print("success ${name}");
      core.ItemEnvelope item = core.ItemEnvelope.fromJson(json.decode(outString) as Map<String, dynamic>);
      if (item.inventoryImageData != null) {
        item.inventoryImageData =
            createImageData(correctImagePath("${projectDirectoryPath}/data/image_sources/${item.inventoryImageData}"));
      }
      if (item.mapImageData != null) {
        item.mapImageData =
            createImageData(correctImagePath("${projectDirectoryPath}/data/image_sources/${item.mapImageData}"));
      }
      return item;
    } catch (e) {
      print("fail ${name} $e");
    }
    return null;
  }

  String correctImagePath(String path) {
    return path.replaceFirst("/data/image_sources/data/image_sources", "/data/image_sources");
  }

  Future<Map<String, core.ItemEnvelope>> getItems() async {
    List<FileSystemEntity> entities = Directory("${projectDirectoryPath}/data/items").listSync(recursive: true);
    Map<String, core.ItemEnvelope> out = {};
    for (FileSystemEntity entity in entities) {
      if (entity is File) {
        if (path.extension(entity.path) == ".ts") {
          String name = path.basenameWithoutExtension(entity.path);
          out[name] = await getItemByName(name);
        }
      }
    }
    return out;
  }
}
