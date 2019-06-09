import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration5 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("_Hero", SchemaColumn.relationship("user", ManagedPropertyType.integer, relatedTableName: "_User", relatedColumnName: "id", rule: DeleteRule.cascade, isNullable: false, isUnique: false));
		database.deleteColumn("_Hero", "userId");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    