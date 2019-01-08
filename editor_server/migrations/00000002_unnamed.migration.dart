import 'dart:async';

import 'package:aqueduct/aqueduct.dart';   

class Migration2 extends Migration { 
  @override
  Future upgrade() async {
   database.createTable(SchemaTable("_Tale", [
SchemaColumn("id", ManagedPropertyType.string, isPrimaryKey: true, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("authorEmail", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("lobbyTale", ManagedPropertyType.document, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("taleDataVersion", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, defaultValue: "0", isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("taleVersion", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, defaultValue: "0", isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("taleData", ManagedPropertyType.document, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
],
));


  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    