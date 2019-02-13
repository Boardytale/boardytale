import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:editor_server/model/tale.dart';
import 'package:io_utils/aqueduct/wraps.dart';
import 'package:shared/model/model.dart' as shared;

class CompiledTaleController extends ResourceController {
  CompiledTaleController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> getCompiledTaleByName(@Bind.body() IdWrap idWrap) async {
    var query = Query<Tale>(context)
      ..where((tale) => tale.name).equalTo("${idWrap.id}Compiled")
      ..where((tale) => tale.compiled).equalTo(true);
    Tale result = await query.fetchOne();
    shared.TaleCompiled out = shared.TaleCompiled.fromJson(
        result.taleData.data as Map<String, dynamic>);

    return Response.ok(out.toJson());
  }
}
