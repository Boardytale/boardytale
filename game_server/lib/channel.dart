import 'dart:io';
import 'dart:async';

import 'package:aqueduct/aqueduct.dart';
import 'package:game_server/controller/tale_controller.dart';


class MyConfiguration extends Configuration {
  MyConfiguration() : super.fromFile(File("config.yaml"));

  DatabaseConfiguration database;
}

class GameServerChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/tale").link(() => TaleController());
    router.route("/authors").linkFunction((request) async {
      return Response.ok({"key": "aa"});
    });

    return router;
  }
}
