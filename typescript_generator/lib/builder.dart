import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:typescript_generator/src/typescript_generator.dart';

Builder todoReporter(BuilderOptions options) => LibraryBuilder(TodoReporterGenerator(), formatOutput: (String input) {
      return input;
    }, generatedExtension: '.ts');
