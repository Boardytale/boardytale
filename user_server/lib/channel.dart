import 'package:io_utils/io_utils.dart';
import 'package:core/configuration/configuration.dart' as core;
import 'package:user_server/controller/temporary_user_controller.dart';
import 'package:user_server/controller/user_controller.dart';
import 'package:user_server/controller/user_inner_authentication.dart';

import 'user_server.dart';

class UserServerChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    final core.BoardytaleConfiguration boardytaleConfiguration = getConfiguration();
    core.DatabaseConfiguration database = boardytaleConfiguration.userDatabase;
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final ManagedDataModel dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final PostgreSQLPersistentStore psc = PostgreSQLPersistentStore.fromConnectionInfo(
        database.username, database.password, database.host, database.port, database.databaseName);

    context = ManagedContext(dataModel, psc);

    UserInnerAuthController(context, boardytaleConfiguration);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/login").link(() => UserController(context));
    router.route("/createTemporaryUser").link(() => TemporaryUserController(context));
    router.route("/*").link(() => FileController("../www/"));
    return router;
  }
}
