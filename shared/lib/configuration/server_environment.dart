part of configuration;

@JsonSerializable()
@Typescript()
class Uri {
  String host;
  num port;

  static Uri fromJson(Map<String, dynamic> json) {
    return _$UriFromJson(json);
  }
}

@JsonSerializable()
@Typescript()
class DatabaseConfiguration {
  String username;
  String password;
  String host;
  int port;
  String databaseName;

  static fromJson(Map<String, dynamic> json) {
    return _$DatabaseConfigurationFromJson(json);
  }
}
@JsonSerializable()
@Typescript()
class ServerConfiguration {
  List<Uri> uris;
  String route;
  String innerRoute;
  String pathToExecutable;
  String pathToWorkingDirectory;
  ExecutableType executableType;

  static ServerConfiguration fromJson(Map<String, dynamic> json) {
    return _$ServerConfigurationFromJson(json);
  }
}
@JsonSerializable()
@Typescript()
class FrontEndDevelopment {
  bool active;
  num port;
  String route;

  static fromJson(Map<String, dynamic> json) {
    return _$FrontEndDevelopmentFromJson(json);
  }
}
@JsonSerializable()
@Typescript()
class BoardytaleConfiguration {
  ServerConfiguration gameServer;
  ServerConfiguration editorServer;
  DatabaseConfiguration userDatabase;
  DatabaseConfiguration editorDatabase;
  ServerConfiguration userServer;
  ServerConfiguration heroesServer;
  ServerConfiguration aiServer;
  ServerConfiguration proxyServer;
  FrontEndDevelopment gameStaticDev;
  FrontEndDevelopment editorStaticDev;

  static fromJson(Map<String, dynamic> json) {
    return _$BoardytaleConfigurationFromJson(json);
  }
}

@Typescript()
enum ExecutableType {
  @JsonValue('ts-node')
  tsNode,
  @JsonValue('js')
  js,
  @JsonValue('dart')
  dart,
}
