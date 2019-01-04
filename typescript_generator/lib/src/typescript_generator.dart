import 'dart:async';
import 'dart:convert';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:typescript_reporter/typescript_reporter.dart';

class EnumField {
}

class TypescriptGenerator extends GeneratorForAnnotation<Typescript> {
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      final name = element.name;
      return '// $name ${element.runtimeType}';
    }
//
    final classElement = element as ClassElement;

    if (classElement.isEnum) {

//      out.add(classElement.toString());
//
//      out.add(classElement.fields.map((field) {
//        return field.name;
//      }).join(','));
//
//      out.add(classElement.fields.map((field) {
//        return field.type.name;
//      }).join(','));
//
//      out.add(classElement.fields.map((field) {
//        return field.metadata.map((annotation) {
//          return 'annotation name' + annotation.constantValue.type.name;
//        }).join(',');
//      }).join(','));
//
//      out.add(classElement.fields.map((field) {
//        return 'field ' + field.metadata.map((annotation) {
//          return 'annotation: ' + annotation.constantValue.type.typeParameters.map((p) {
//            return 'param ' + p.name;
//          }).join(',');
//        }).join(',');
//      }).join(','));
//
//      out.add(classElement.fields.map((field) {
//        return 'field ' + field.metadata.map((annotation) {
//          return 'annotation: ' + json.encode(annotation.constantValue.toMapValue());
//        }).join(',');
//      }).join(','));
//
//      out.add(classElement.fields.map((field) {
//        return 'field ' + field.metadata.map((annotation) {
//          return 'annotation computed: ' + json.encode(annotation.computeConstantValue().toString());
//        }).join(',');
//      }).join(','));
//
//      out.add(classElement.fields.map((field) {
//        return 'field ' + field.metadata.map((annotation) {
//          return 'annotation computed: ' +
//              json.encode(annotation.computeConstantValue().getField('value').toStringValue());
//        }).join(',');
//      }).join(','));
//
//      out.add(classElement.fields.map((field) {
//        return 'field ' + field.metadata.map((annotation) {
//          return 'annotation computed fields: ' + json.encode(annotation.computeConstantValue().type.typeParameters.map((a){
//            return a.displayName;
//          }).join('|'));
//        }).join(',');
//      }).join(','));

      List<FieldElement> fields = classElement.fields;
      List<String> enumValues = [];


      fields.forEach((field) {
        field.metadata.forEach((ElementAnnotation annotation) {
          if (annotation.constantValue.type.name == 'JsonValue') {
             enumValues.add(annotation.computeConstantValue().getField('value').toStringValue());
          }
        });
      });

      return 'export type ${classElement.name} = ${enumValues.map((value)=>"'$value'").join('|')}';
    }

    List<String> fields = [];
    classElement.fields.forEach((field) {
//      fields += '// field.name ${field.name} \n';
//      fields += '// field.type ${field.type.name} \n';
//      fields += '// field.runetype ${field.type.runtimeType} \n';
//      DartType type = field.type;
//      if (type is ParameterizedType) {
//        type.typeArguments.forEach((p) {
//          fields += '// parameter.name ${p.name} \n';
//          fields += '// parameter.type ${p.name} \n';
//          fields += '// parameter.runetype ${p.runtimeType} \n';
//        });
//      }
      fields.add('${field.name}: ${_resolveType(field.type)};');
    });
    return '''
       export interface ${classElement.name} {
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
    }
    return type.name;
  }
}
