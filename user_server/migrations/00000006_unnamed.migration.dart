import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration6 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("_Hero", SchemaColumn("heroData", ManagedPropertyType.document, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false));
		database.deleteColumn("_Hero", "lobbyTale");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    