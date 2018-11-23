import 'package:todo_reporter/todo_reporter.dart';

part 'todo.g.dart';

@Todo('Complete implementation of TestClass')
class TestClass {
  String pole;
  InnerClass inner;
}

@Todo('Complete implementation of TestClass')
class InnerClass {
  String innerPole;
}