import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration2 extends Migration {
  @override
  Future upgrade() async {
    database.addColumn(
        "_Tale",
        SchemaColumn("compiled", ManagedPropertyType.boolean,
            isPrimaryKey: false,
            autoincrement: false,
            defaultValue: "false",
            isIndexed: false,
            isNullable: false,
            isUnique: false));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {}
}
