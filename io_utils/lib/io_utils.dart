import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path_lib;
import 'package:utils/utils.dart';
import 'dart:async';
import 'package:args/args.dart' as arg_lib;

Map<String, dynamic> getFileMap(Directory dir) {
  Map<String, dynamic> out = <String, dynamic>{};
  for (FileSystemEntity f in dir.listSync()) {
    String key = convertToCamelCase(path_lib.basename(f.path));
    if (FileSystemEntity.isFileSync(f.path)) {
      File file = new File(f.path);
      String ext = path_lib.extension(file.path);
      try {
        if (ext == ".jpg" || ext == ".png" || ext == ".jpeg" || ext == ".gif") {
          String contentType = "image/${ext.replaceAll(".", "")}";
          List<int> byteList = file.readAsBytesSync();
          String header = "data:$contentType;base64,";
          String base64 = BASE64.encode(byteList);
          out[key] = "$header$base64";
        } else {
          out[key] = file.readAsStringSync();
        }
      } catch (e) {
        out[key] = "error";
      }
    } else if (FileSystemEntity.isDirectorySync(f.path)) {
      out[key] = getFileMap(new Directory(f.path));
    }
  }
  return out;
}


String dartExecutable = "dart${Platform.operatingSystem == 'linux'
    ? ""
    : ".exe"}";

String pubExecutable = "pub${Platform.operatingSystem == 'linux'
    ? ""
    : ".bat"}";

Future<bool> waitForSignal(Process process, String signal,
    {String printPrefix: null}) {
  Stream<List<int>> stdout = process.stdout;
  Stream<List<int>> stderr = process.stderr;
  Completer<bool> completer = new Completer<bool>();
  stderr.transform(UTF8.decoder).listen((String data) {
    if (printPrefix != null) {
      print("error$printPrefix: $data");
    } else {
      print(data);
    }
  });
  stdout.transform(UTF8.decoder).listen((String data) {
    if (data.contains(signal)) {
      completer.complete(true);
    }
    if (printPrefix != null) {
      print("out$printPrefix: $data");
    } else {
      print(data);
    }
  });
  return completer.future;
}

void printFromOutputStreams(Object process, [String prefix = ""]) {
  Stream<List<int>> stdout;
  Stream<List<int>> stderr;
  if (process is Process) {
    stdout = process.stdout;
    stderr = process.stderr;
    stderr.transform(UTF8.decoder).listen((String data) {
      print("error$prefix: $data");
    });
    stdout.transform(UTF8.decoder).listen((String data) {
      print("out$prefix: $data");
    });
  } else if (process is ProcessResult) {
    if (process.stdout is String) {
      if (process.stdout != "")
        print("out$prefix: ${process.stdout}");
    } else {
      print("out$prefix: ${new String.fromCharCodes(process.stdout as List<int>)}");
    }
    if (process.stderr is String) {
      if (process.stderr != "")
        print("err$prefix: ${process.stderr}");
    } else {
      print("err$prefix: ${new String.fromCharCodes(process.stderr as List<int>)}");
    }
  } else {
    throw new ArgumentError("unknown type - cannot extract stdout and stderr");
  }
}

String getProjectDirectoryName() {
  Directory projectDir = Directory.current;
  int overflowProtection =0;
  while(!isFileInFileSystemEntityList(projectDir.listSync(followLinks: false),"projectroot")){
    if(overflowProtection++>30){
      throw new Exception("Cannot found project dir");
    }
    projectDir = projectDir.parent;
  }
  return projectDir.path;
}

bool isFileInFileSystemEntityList(List<FileSystemEntity> list, String filename){
  for(FileSystemEntity f in list){
    if(path_lib.basename(f.path)==filename){
      return true;
    }
  }
  return false;
}

Future<bool> terminateMe(int port,[int terminateDelay = 50]) async{
  try {
    var socket = await Socket.connect('127.0.0.1', port);
    socket.write('terminate');
    // time to terminate
    await new Future<dynamic>.delayed(new Duration(milliseconds: terminateDelay)).then((_){socket.close();});
    return true;
  } catch (e) {
    return false;
  }
}

Future createTerminator(int port) async{
  var serverSocket = await ServerSocket.bind('127.0.0.1', port);
  serverSocket.listen((Socket socket) {
    socket.transform(UTF8.decoder).listen((String message) {
      if (message == "terminate") {
        exit(0);
      }
    });
  });
}


arg_lib.ArgResults parseArgs(void enhanceParser(arg_lib.ArgParser parser),
    List<String> args) {
  arg_lib.ArgParser parser = new arg_lib.ArgParser();
  parser.addOption("loglevel",
      abbr: "l",
      allowed: [
        "ALL",
        "FINEST",
        "FINER",
        "FINE",
        "CONFIG",
        "INFO",
        "WARNING",
        "SEVERE",
        "SHOUT",
        "OFF"
      ],
      defaultsTo: "INFO",
      help: "set logLevel for Logger");
  if (enhanceParser != null) enhanceParser(parser);
  return parser.parse(args);
}


void recursiveFolderCopySync(String path1, String path2,[List<String> forbiddenFileNames]) {
  if(forbiddenFileNames==null){
    forbiddenFileNames = [];
  }
  Directory dir1 = new Directory(path1);
  if (!dir1.existsSync()) {
    throw new Exception(
        'Source directory "${dir1.path}" does not exist, nothing to copy'
    );
  }
  Directory dir2 = new Directory(path2);
  if (!dir2.existsSync()) {
    dir2.createSync(recursive: true);
  }

  dir1.listSync().forEach((FileSystemEntity element) {
    String newPath = "${dir2.path}/${path_lib.basename(element.path)}";
    if (element is File) {
      File newFile = new File(newPath);
      newFile.writeAsBytesSync(element.readAsBytesSync());
    } else if (element is Directory) {
      if(!forbiddenFileNames.contains(path_lib.basename(element.path))){
        recursiveFolderCopySync(element.path, newPath, forbiddenFileNames);
      }
    } else {
      throw new Exception('File is neither File nor Directory. HOW?!');
    }
  });
}


void deleteRecursively(Directory root,
    {bool deleteFileChecker(String fileName), bool deleteDirectoryChecker(String dirName)}) {
  root.listSync().forEach((FileSystemEntity element) {
    if (element is File) {
      if (deleteFileChecker(path_lib.basename(element.path))) {
        print("deleted ${element.path}");
        element.deleteSync();
      }
    } else if (element is Directory) {
      if (deleteDirectoryChecker(path_lib.basename(element.path))) {
        print("deleted ${element.path}");
        element.deleteSync(recursive: true);
      } else {
        deleteRecursively(element, deleteFileChecker: deleteFileChecker,
            deleteDirectoryChecker: deleteDirectoryChecker);
      }
    } else {
      throw new Exception('File is neither File nor Directory. HOW?!');
    }
  });
}
String thisPackagePath() {
  Directory directory = Directory.current;
  while(!directory.listSync().any((entity)=>entity.path.contains("pubspec.yaml"))){
    directory=directory.parent;
  }

  return directory.path;
}

//arg_lib.ArgResults parseServerRunnerArgs(List<String> args) {
//  arg_lib.ArgParser parser = new arg_lib.ArgParser();
//  parser.addOption("database",
//      abbr: "d",
//      allowed: ["test", "devel", "production"],
//      defaultsTo: "devel",
//      help: "Start server with selected database (default = devel database)");
//  parser.addOption("port", abbr: "p", defaultsTo: "9999");
//  parser.addOption("service-port", abbr: "s", defaultsTo: "3333");
//  parser.addFlag("production", defaultsTo: false);
//  parser.addFlag('help', abbr: 'h', negatable: false,
//      help: "Displays this help information.");
//  arg_lib.ArgResults results = parser.parse(args);
//  if (results["help"]) {
//    print(parser.usage);
//    return null;
//  }
//  return results;
//}
