// GENERATED CODE - DO NOT MODIFY BY HAND

part of configuration;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatabaseConfiguration _$DatabaseConfigurationFromJson(
    Map<String, dynamic> json) {
  return DatabaseConfiguration()
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..host = json['host'] as String
    ..port = json['port'] as num
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
    ..uri = json['uri'] as String
    ..uris = (json['uris'] as List)?.map((e) => e as String)?.toList()
    ..route = json['route'] as String
    ..innerRoute = json['innerRoute'] as String;
}

Map<String, dynamic> _$ServerConfigurationToJson(
        ServerConfiguration instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'uris': instance.uris,
      'route': instance.route,
      'innerRoute': instance.innerRoute
    };

FrontEndDevelopment _$FrontEndDevelopmentFromJson(Map<String, dynamic> json) {
  return FrontEndDevelopment()
    ..active = json['active'] as bool
    ..route = json['route'] as String
    ..proxyPass = json['proxyPass'] as String;
}

Map<String, dynamic> _$FrontEndDevelopmentToJson(
        FrontEndDevelopment instance) =>
    <String, dynamic>{
      'active': instance.active,
      'route': instance.route,
      'proxyPass': instance.proxyPass
    };

BoardytaleConfiguration _$BoardytaleConfigurationFromJson(
    Map<String, dynamic> json) {
  return BoardytaleConfiguration()
    ..gameServer = json['gameServer'] == null
        ? null
        : ServerConfiguration.fromJson(
            json['gameServer'] as Map<String, dynamic>)
    ..editorServer = json['editorServer'] == null
        ? null
        : ServerConfiguration.fromJson(
            json['editorServer'] as Map<String, dynamic>)
    ..editorDatabase = json['editorDatabase'] == null
        ? null
        : DatabaseConfiguration.fromJson(
            json['editorDatabase'] as Map<String, dynamic>)
    ..userService = json['userService'] == null
        ? null
        : ServerConfiguration.fromJson(
            json['userService'] as Map<String, dynamic>)
    ..userDatabase = json['userDatabase'] == null
        ? null
        : DatabaseConfiguration.fromJson(
            json['userDatabase'] as Map<String, dynamic>)
    ..aiService = json['aiService'] == null
        ? null
        : ServerConfiguration.fromJson(
            json['aiService'] as Map<String, dynamic>)
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
      'gameServer': instance.gameServer,
      'editorServer': instance.editorServer,
      'editorDatabase': instance.editorDatabase,
      'userService': instance.userService,
      'userDatabase': instance.userDatabase,
      'aiService': instance.aiService,
      'gameStaticDev': instance.gameStaticDev,
      'editorStaticDev': instance.editorStaticDev
    };
