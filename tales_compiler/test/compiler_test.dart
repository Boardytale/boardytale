import 'package:test/test.dart';
import 'dart:async';
import '../src/compile.dart' as compile;

main() {
  group("compiler", () {
     compile.main();
  });
}
