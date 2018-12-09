import 'package:io_utils/io_utils.dart';
import 'package:shared/configuration/configuration.dart' as shared;
import 'package:user_server/controller/user_controller.dart';

import 'user_server.dart';

class UserServerChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    final shared.BoardytaleConfiguration boardytaleConfiguration = getConfiguration();
    shared.DatabaseConfiguration database = boardytaleConfiguration.userDatabase;
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final ManagedDataModel dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final PostgreSQLPersistentStore psc = PostgreSQLPersistentStore.fromConnectionInfo(
        database.username, database.password, database.host, database.port, database.databaseName);

    context = ManagedContext(dataModel, psc);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/login").link(() => UserController(context));
    router.route("/userApi/login").link(() => UserController(context));
    router.route("/*").link(() => FileController("../www/"));
    return router;
  }
}