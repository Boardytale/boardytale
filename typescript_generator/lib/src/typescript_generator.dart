import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

class TodoReporterGenerator extends GeneratorForAnnotation<JsonSerializable> {
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      final name = element.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the JsonSerializable annotation from `$name`.', element: element);
    }
//
    final classElement = element as ClassElement;
    String fields = '';
    classElement.fields.forEach((field) {
      fields += '${field.name}: ${_resolveType(field.type.name)};\n';
    });
//    final helper = _GeneratorHelper(this, classElement, annotation);
//    return helper._generate();
    return '''
       export interface ${classElement.name} {
          $fields
       }
    ''';
  }

  String _resolveType(String type) {
    switch(type){
      case 'String': return 'string';
      case 'int': return 'number';
      case 'doble': return 'number';
      case 'num': return 'number';
      case 'bool': return 'boolean';
      case 'List': return 'Array<any>';
      case 'Map': return 'any';
    }
    return type;
  }
}
