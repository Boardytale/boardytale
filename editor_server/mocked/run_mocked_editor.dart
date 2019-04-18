import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:core/configuration/configuration.dart';
import 'package:io_utils/io_utils.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:core/model/model.dart' as core;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

String projectDirectoryPath = getProjectDirectory().path;

void main(){
  final BoardytaleConfiguration config = getConfiguration();
  MockedEditor editor = MockedEditor(config);
}


class MockedEditor {
  MockedEditor(this.config) {
    run();
  }
  final BoardytaleConfiguration config;
  int counter = 0;

  void run() async {
    var handler = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(_echoRequest);

    var server = await io.serve(handler, 'localhost', config.editorServer.uris.first.port.toInt());

    // Enable content compression
    server.autoCompress = true;

    print('Serving mocked editor at http://${server.address.host}:${server.port}');

    print(await getLobbies());
  }

  Future<List> getLobbies() async{
    List<FileSystemEntity> entities = Directory("${projectDirectoryPath}/core/lib/data/tales").listSync(recursive: true);
    List out = [];
    for (FileSystemEntity entity in entities) {
      if (entity is File) {
        if(path.extension(entity.path) == ".ts"){
          ProcessResult result = await Process.run("npm", ["run", "ts-node", "libs/generate-data-json.ts", entity.path], workingDirectory: projectDirectoryPath, runInShell: true);
          String outString = result.stdout.toString();
          outString = outString.substring(outString.indexOf("start:") + 6);
          print(entity.path);
          print(outString);
          try{
            print("success");
            core.TaleCompiled tale = core.TaleCompiled.fromJson(json.decode(outString) as Map<String, dynamic>);
            out.add(tale.lobby.toJson());
          }catch(e){
            print("fail");
          }
        }
      }
    }
    return out;
  }


  Future<shelf.Response> _echoRequest(shelf.Request request) async {
    if(request.url.path == "inner/lobbyList"){
      String out = json.encode(await getLobbies());
      print(out);
      return shelf.Response.ok(out);
    }else{

    }

    String body = await request.readAsString();
    return shelf.Response.ok(json.encode({}));
  }
}
