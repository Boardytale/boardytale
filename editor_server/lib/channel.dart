import 'package:editor_server/controller/compiled_tale_controller.dart';
import 'package:editor_server/controller/image_controller.dart';
import 'package:editor_server/controller/lobby_data_controller.dart';
import 'package:editor_server/controller/tale_controller.dart';
import 'package:editor_server/controller/unit_controller.dart';
import 'package:io_utils/io_utils.dart';
import 'package:core/configuration/configuration.dart' as core;
import 'package:editor_server/editor_server.dart';

import 'editor_server.dart';

core.BoardytaleConfiguration boardytaleConfiguration;
core.DatabaseConfiguration database;
ManagedDataModel dataModel;

ManagedContext generateContext() {
  final PostgreSQLPersistentStore psc = PostgreSQLPersistentStore.fromConnectionInfo(
      database.username, database.password, database.host, database.port, database.databaseName);
  return ManagedContext(dataModel, psc);
}

class EditorServerChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    boardytaleConfiguration = getConfiguration();
    database = boardytaleConfiguration.editorDatabase;
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    context = generateContext();
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/images/[:type]").link(() => ImageController(context));
    router.route("/tales/[:operation]").link(() => TaleController(context));
    router.route("/units/[:operation]").link(() => UnitController(context));
    router.route("/inner/lobbyList").link(() => LobbyDataController(context));
    router.route("/inner/taleByName").link(() => CompiledTaleController(context));
    return router;
  }
}
