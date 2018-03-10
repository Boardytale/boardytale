import 'dart:io';
import 'package:io_utils/io_utils.dart';
import 'package:test/test.dart';
import '../bin/compile.dart' as compile;

main() {
  group("compiler", () {
    String compilerPath = thisPackagePath();
    setUpAll((){
     compile.main();
    });
    test("0",(){
      expect(new File("$compilerPath/output/0.json").exists(),completion(true));
    });
    test("arena",(){
      expect(new File("$compilerPath/output/arena.json").exists(),completion(true));
    });
  });
}
