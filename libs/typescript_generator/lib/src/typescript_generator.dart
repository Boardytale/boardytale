import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:typescript_reporter/typescript_reporter.dart';

class EnumField {}

class TypescriptGenerator extends GeneratorForAnnotation<Typescript> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      final name = element.name;
      return '// $name ${element.runtimeType}';
    }
    final classElement = element as ClassElement;
    if (classElement.isEnum) {
      List<FieldElement> fields = classElement.fields;
      List<String> enumValues = [];
      fields.forEach((field) {
        field.metadata.forEach((ElementAnnotation annotation) {
          if (annotation.computeConstantValue() != null) {
            if (annotation.computeConstantValue().type.name == 'JsonValue') {
              enumValues.add(annotation
                  .computeConstantValue()
                  .getField('value')
                  .toStringValue());
            }
          }
        });
      });
      if(enumValues.isEmpty){
        return "";
      }
      return 'export type ${classElement.name} = ${enumValues.map((value) => "'$value'").join('|')}';
    }

    List<String> fields = [];
    classElement.fields.forEach((FieldElement field) {
//      fields.add("// isFinal ${field.isFinal}");
//      fields.add("// isConst ${field.isConst}");
//      fields.add("// isSynthetic ${field.isSynthetic}");

      if (field.isFinal || field.isConst || field.isSynthetic) {
        return;
      }
      bool isOptional = false;
      for (var annotation in field.metadata) {
        fields.add("// annotation ${annotation}");
        if (annotation.toString().contains("TypescriptOptional")) {
          isOptional = true;
        }
        if (annotation.toString().contains("TypescriptSkip")) {
          fields.add("// skipped ${annotation}");
          return;
        }
      }
      if (field != null) {
        fields.add(
            '${field.name}${isOptional ? "?" : ""}: ${_resolveType(field.type)};');
      }
    });

    return '''
       export interface ${classElement.name}${classElement.allSupertypes.isNotEmpty ? " extends ${classElement.allSupertypes.first.name}" : ""} {
          ${fields.join('\n')}
       }
    ''';
  }

  String _resolveType(DartType type) {
    if (type is ParameterizedType && type.typeArguments.isNotEmpty) {
      String parameters = '<' +
          type.typeArguments.map((p) {
            return _resolveType(p);
          }).join(",") +
          '>';
      switch (type.name) {
        case 'List':
          return 'Array' + parameters;
        case 'Map':
          if (type.typeArguments.length == 2) {
            String firstType = _resolveType(type.typeArguments[0]);
            if (firstType == "any") {
              firstType = "string";
            }
            if (firstType == "string") {
              return '{[key:string]:${_resolveType(type.typeArguments[1])}}';
            }
            return '{[key in ${firstType}]?:${_resolveType(type.typeArguments[1])}}';
          }
          return 'any';
      }
      return 'any';
    }

    switch (type.name) {
      case 'String':
        return 'string';
      case 'int':
        return 'number';
      case 'double':
        return 'number';
      case 'num':
        return 'number';
      case 'bool':
        return 'boolean';
      case 'List':
        return 'Array<any>';
      case 'Map':
        return 'any';
      case 'DateTime':
        return 'string';
      case 'dynamic':
        return 'any';
    }
    return type.name;
  }
}
