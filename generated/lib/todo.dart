import 'package:json_annotation/json_annotation.dart';
import 'package:generate_typescript/generate_typescript.dart';
part 'todo.g.dart';

@JsonSerializable()
@GenerateTypescript()
class TestClass {
  String pole;
  InnerClass inner;
}

@JsonSerializable()
class InnerClass {
  String innerPole;

  InnerClass();

  factory InnerClass.fromJson(Map<String, dynamic> json){
    return _$InnerClassFromJson(json);
  }
}

@JsonSerializable()
class SpecificInnerClass extends InnerClass {
  String specificInnerPole;

  SpecificInnerClass();

  SpecificInnerClass.fromJson(Map<String, dynamic> json) {

  }
}