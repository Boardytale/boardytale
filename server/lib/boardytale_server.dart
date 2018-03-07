library boardytale_server;

import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:tales_compiler/tales_compiler.dart';
import 'dart:convert';
import 'dart:io';
import 'package:boardytale_commons/model/model.dart';
import 'package:io_utils/io_utils.dart';

part 'controllers/tales.dart';

String pathToData = "../data";

class QuestionController extends HTTPController {
  var questions = [
    "How much wood can a woodchuck chuck?",
    "What's the tallest mountain in the world?"
  ];

  @httpGet
  Future<Response> getAllQuestions() async {
    return new Response.ok(questions);
  }

  @httpGet
  Future<Response> getQuestionAtIndex(@HTTPPath("index") int index) async {
    if (index < 0 || index >= questions.length) {
      return new Response.notFound();
    }

    return new Response.ok(questions[index]);
  }
}


class BoardytaleRequestSink extends RequestSink {
  BoardytaleRequestSink(ApplicationConfiguration options) : super (options);

  @override
  void setupRouter(Router router) {
    router
        .route("/questions/[:index(\\d+)]")
        .generate(() => new QuestionController());
    router
        .route("/tales/[:index(\\d+)]")
        .generate(() => new TalesController());
  }

  static Future initializeApplication(ApplicationConfiguration config) async {
    Map<String, dynamic> fileMap = getFileMap(new Directory(pathToData));
    Map<int, Tale> tales = getTalesFromFileMap(fileMap);

    tales.forEach((k,v){
      new File("web/tales/${v.id}.json").writeAsStringSync(JSON.encode(TaleAssetsPack.pack(v)));
    });
//    if (config.configurationFilePath == null) {
//      throw new ApplicationStartupException(
//          "No configuration file found. See README.md.");
//    }

//    var configFileValues =
//    new WildfireConfiguration(config.configurationFilePath);
//    config.options[ConfigurationValuesKey] = configFileValues;
//
//    var loggingServer = configFileValues.logging.loggingServer;
//    await loggingServer?.start();
//    config.options[LoggingTargetKey] = loggingServer?.getNewTarget();
  }

}


