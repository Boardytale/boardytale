import 'package:user_server/controller/user_controller.dart';

import 'user_server.dart';

class MyConfiguration extends Configuration {
  MyConfiguration() : super.fromFile(File("config.yaml"));

  DatabaseConfiguration database;
}

class UserServerChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final ManagedDataModel dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final config = MyConfiguration();
    final PostgreSQLPersistentStore psc = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username, config.database.password, config.database.host, config.database.port, config.database.databaseName);

    context = ManagedContext(dataModel, psc);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/login").link(() => UserController(context));

    return router;
  }
}