// GENERATED CODE - DO NOT MODIFY BY HAND

part of configuration;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uri _$UriFromJson(Map<String, dynamic> json) {
  return Uri()
    ..host = json['host'] as String
    ..port = json['port'] as num;
}

Map<String, dynamic> _$UriToJson(Uri instance) =>
    <String, dynamic>{'host': instance.host, 'port': instance.port};

DatabaseConfiguration _$DatabaseConfigurationFromJson(
    Map<String, dynamic> json) {
  return DatabaseConfiguration()
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..host = json['host'] as String
    ..port = json['port'] as int
    ..databaseName = json['databaseName'] as String;
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
  return ServerConfiguration()
    ..uris = (json['uris'] as List)
        ?.map((e) => e == null ? null : Uri.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..innerPort = json['innerPort'] as int
    ..route = json['route'] as String
    ..pathToExecutable = json['pathToExecutable'] as String
    ..pathToWorkingDirectory = json['pathToWorkingDirectory'] as String
    ..executableType =
        _$enumDecodeNullable(_$ExecutableTypeEnumMap, json['executableType'])
    ..disabledForRunner = json['disabledForRunner'] as bool;
}

Map<String, dynamic> _$ServerConfigurationToJson(
        ServerConfiguration instance) =>
    <String, dynamic>{
      'uris': instance.uris?.map((e) => e?.toJson())?.toList(),
      'innerPort': instance.innerPort,
      'route': instance.route,
      'pathToExecutable': instance.pathToExecutable,
      'pathToWorkingDirectory': instance.pathToWorkingDirectory,
      'executableType': _$ExecutableTypeEnumMap[instance.executableType],
      'disabledForRunner': instance.disabledForRunner
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

GameServerConfiguration _$GameServerConfigurationFromJson(
    Map<String, dynamic> json) {
  return GameServerConfiguration()
    ..uris = (json['uris'] as List)
        ?.map((e) => e == null ? null : Uri.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..innerPort = json['innerPort'] as int
    ..route = json['route'] as String
    ..pathToExecutable = json['pathToExecutable'] as String
    ..pathToWorkingDirectory = json['pathToWorkingDirectory'] as String
    ..executableType =
        _$enumDecodeNullable(_$ExecutableTypeEnumMap, json['executableType'])
    ..disabledForRunner = json['disabledForRunner'] as bool
    ..runMockedEditor = json['runMockedEditor'] as bool;
}

Map<String, dynamic> _$GameServerConfigurationToJson(
        GameServerConfiguration instance) =>
    <String, dynamic>{
      'uris': instance.uris?.map((e) => e?.toJson())?.toList(),
      'innerPort': instance.innerPort,
      'route': instance.route,
      'pathToExecutable': instance.pathToExecutable,
      'pathToWorkingDirectory': instance.pathToWorkingDirectory,
      'executableType': _$ExecutableTypeEnumMap[instance.executableType],
      'disabledForRunner': instance.disabledForRunner,
      'runMockedEditor': instance.runMockedEditor
    };

FrontEndDevelopment _$FrontEndDevelopmentFromJson(Map<String, dynamic> json) {
  return FrontEndDevelopment()
    ..active = json['active'] as bool
    ..port = json['port'] as num
    ..route = json['route'] as String;
}

Map<String, dynamic> _$FrontEndDevelopmentToJson(
        FrontEndDevelopment instance) =>
    <String, dynamic>{
      'active': instance.active,
      'port': instance.port,
      'route': instance.route
    };

BoardytaleConfiguration _$BoardytaleConfigurationFromJson(
    Map<String, dynamic> json) {
  return BoardytaleConfiguration()
    ..gameServer = json['gameServer'] == null
        ? null
        : GameServerConfiguration.fromJson(
            json['gameServer'] as Map<String, dynamic>)
    ..editorServer = json['editorServer'] == null
        ? null
        : ServerConfiguration.fromJson(
            json['editorServer'] as Map<String, dynamic>)
    ..userDatabase = json['userDatabase'] == null
        ? null
        : DatabaseConfiguration.fromJson(
            json['userDatabase'] as Map<String, dynamic>)
    ..editorDatabase = json['editorDatabase'] == null
        ? null
        : DatabaseConfiguration.fromJson(
            json['editorDatabase'] as Map<String, dynamic>)
    ..userServer = json['userServer'] == null
        ? null
        : ServerConfiguration.fromJson(
            json['userServer'] as Map<String, dynamic>)
    ..aiServer = json['aiServer'] == null
        ? null
        : ServerConfiguration.fromJson(json['aiServer'] as Map<String, dynamic>)
    ..proxyServer = json['proxyServer'] == null
        ? null
        : ServerConfiguration.fromJson(
            json['proxyServer'] as Map<String, dynamic>)
    ..loggerServer = json['loggerServer'] == null
        ? null
        : ServerConfiguration.fromJson(
            json['loggerServer'] as Map<String, dynamic>)
    ..gameStaticDev = json['gameStaticDev'] == null
        ? null
        : FrontEndDevelopment.fromJson(
            json['gameStaticDev'] as Map<String, dynamic>)
    ..editorStaticDev = json['editorStaticDev'] == null
        ? null
        : FrontEndDevelopment.fromJson(
            json['editorStaticDev'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BoardytaleConfigurationToJson(
        BoardytaleConfiguration instance) =>
    <String, dynamic>{
      'gameServer': instance.gameServer?.toJson(),
      'editorServer': instance.editorServer?.toJson(),
      'userDatabase': instance.userDatabase?.toJson(),
      'editorDatabase': instance.editorDatabase?.toJson(),
      'userServer': instance.userServer?.toJson(),
      'aiServer': instance.aiServer?.toJson(),
      'proxyServer': instance.proxyServer?.toJson(),
      'loggerServer': instance.loggerServer?.toJson(),
      'gameStaticDev': instance.gameStaticDev?.toJson(),
      'editorStaticDev': instance.editorStaticDev?.toJson()
    };
