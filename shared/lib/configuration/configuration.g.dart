// GENERATED CODE - DO NOT MODIFY BY HAND

part of configuration;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uri _$UriFromJson(Map<String, dynamic> json) {
  return $checkedNew('Uri', json, () {
    final val = Uri();
    $checkedConvert(json, 'host', (v) => val.host = v as String);
    $checkedConvert(json, 'port', (v) => val.port = v as num);
    return val;
  });
}

Map<String, dynamic> _$UriToJson(Uri instance) =>
    <String, dynamic>{'host': instance.host, 'port': instance.port};

DatabaseConfiguration _$DatabaseConfigurationFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('DatabaseConfiguration', json, () {
    final val = DatabaseConfiguration();
    $checkedConvert(json, 'username', (v) => val.username = v as String);
    $checkedConvert(json, 'password', (v) => val.password = v as String);
    $checkedConvert(json, 'host', (v) => val.host = v as String);
    $checkedConvert(json, 'port', (v) => val.port = v as num);
    $checkedConvert(
        json, 'databaseName', (v) => val.databaseName = v as String);
    return val;
  });
}

Map<String, dynamic> _$DatabaseConfigurationToJson(
        DatabaseConfiguration instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'host': instance.host,
      'port': instance.port,
      'databaseName': instance.databaseName
    };

ServerConfiguration _$ServerConfigurationFromJson(Map<String, dynamic> json) {
  return $checkedNew('ServerConfiguration', json, () {
    final val = ServerConfiguration();
    $checkedConvert(
        json,
        'uris',
        (v) => val.uris = (v as List)
            ?.map((e) =>
                e == null ? null : Uri.fromJson(e as Map<String, dynamic>))
            ?.toList());
    $checkedConvert(json, 'route', (v) => val.route = v as String);
    $checkedConvert(json, 'innerRoute', (v) => val.innerRoute = v as String);
    $checkedConvert(
        json, 'pathToExecutable', (v) => val.pathToExecutable = v as String);
    $checkedConvert(
        json,
        'executableType',
        (v) => val.executableType =
            _$enumDecodeNullable(_$ExecutableTypeEnumMap, v));
    return val;
  });
}

Map<String, dynamic> _$ServerConfigurationToJson(
        ServerConfiguration instance) =>
    <String, dynamic>{
      'uris': instance.uris,
      'route': instance.route,
      'innerRoute': instance.innerRoute,
      'pathToExecutable': instance.pathToExecutable,
      'executableType': _$ExecutableTypeEnumMap[instance.executableType]
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$ExecutableTypeEnumMap = <ExecutableType, dynamic>{
  ExecutableType.tsNode: 'ts-node',
  ExecutableType.js: 'js',
  ExecutableType.dart: 'dart'
};

FrontEndDevelopment _$FrontEndDevelopmentFromJson(Map<String, dynamic> json) {
  return $checkedNew('FrontEndDevelopment', json, () {
    final val = FrontEndDevelopment();
    $checkedConvert(json, 'active', (v) => val.active = v as bool);
    $checkedConvert(json, 'host', (v) => val.host = v as String);
    $checkedConvert(json, 'port', (v) => val.port = v as num);
    $checkedConvert(json, 'target', (v) => val.target = v as String);
    return val;
  });
}

Map<String, dynamic> _$FrontEndDevelopmentToJson(
        FrontEndDevelopment instance) =>
    <String, dynamic>{
      'active': instance.active,
      'host': instance.host,
      'port': instance.port,
      'target': instance.target
    };

BoardytaleConfiguration _$BoardytaleConfigurationFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('BoardytaleConfiguration', json, () {
    final val = BoardytaleConfiguration();
    $checkedConvert(
        json,
        'gameServer',
        (v) => val.gameServer = v == null
            ? null
            : ServerConfiguration.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'editorServer',
        (v) => val.editorServer = v == null
            ? null
            : ServerConfiguration.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'userDatabase',
        (v) => val.userDatabase = v == null
            ? null
            : DatabaseConfiguration.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'editorDatabase',
        (v) => val.editorDatabase = v == null
            ? null
            : DatabaseConfiguration.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'userService',
        (v) => val.userService = v == null
            ? null
            : ServerConfiguration.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'heroesService',
        (v) => val.heroesService = v == null
            ? null
            : ServerConfiguration.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'aiService',
        (v) => val.aiService = v == null
            ? null
            : ServerConfiguration.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'gameStaticDev',
        (v) => val.gameStaticDev = v == null
            ? null
            : FrontEndDevelopment.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'editorStaticDev',
        (v) => val.editorStaticDev = v == null
            ? null
            : FrontEndDevelopment.fromJson(v as Map<String, dynamic>));
    return val;
  });
}

Map<String, dynamic> _$BoardytaleConfigurationToJson(
        BoardytaleConfiguration instance) =>
    <String, dynamic>{
      'gameServer': instance.gameServer,
      'editorServer': instance.editorServer,
      'userDatabase': instance.userDatabase,
      'editorDatabase': instance.editorDatabase,
      'userService': instance.userService,
      'heroesService': instance.heroesService,
      'aiService': instance.aiService,
      'gameStaticDev': instance.gameStaticDev,
      'editorStaticDev': instance.editorStaticDev
    };
