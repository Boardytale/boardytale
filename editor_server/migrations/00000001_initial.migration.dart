import 'dart:async';

import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   database.createTable(SchemaTable("_Image", [
SchemaColumn("id", ManagedPropertyType.string, isPrimaryKey: true, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("authorEmail", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("imageType", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("imageDataVersion", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, defaultValue: "0", isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("imageVersion", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, defaultValue: "0", isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("imageData", ManagedPropertyType.document, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
],
));

database.createTable(SchemaTable("_Tag", [
SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("tag", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
],
));

database.createTable(SchemaTable("_TagToImage", [
SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn.relationship("tag", ManagedPropertyType.integer, relatedTableName: "_Tag", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: true),
SchemaColumn.relationship("image", ManagedPropertyType.string, relatedTableName: "_Image", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: true),
],
));


  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    